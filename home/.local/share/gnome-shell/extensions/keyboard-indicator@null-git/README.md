# Keyboard Indicator

A panel indicator showing which keyboards are connected, with a switch to disable
the built-in laptop keyboard while an external one is plugged in.

Built for GNOME Shell 45+ on Wayland, where `xinput disable` doesn't exist.

## What it shows

| Panel label   | Meaning                                                  |
| ------------- | -------------------------------------------------------- |
| `Built-in`    | only the laptop keyboard is connected                    |
| `Both`        | external keyboard connected, built-in still active       |
| _vendor name_ | external keyboard active, built-in disabled (icon dimmed) |

The menu lists each detected keyboard with its state, plus two switches:

- **Built-in keyboard** — toggle it right now
- **Auto-disable when external connected** — do it automatically on plug/unplug

## How disabling works

The kernel's input core exposes an `inhibited` attribute per device. Writing `1`
makes it close the device and stop delivering events; the device stays
enumerated, so nothing re-probes it. Writing `0` brings it back:

```sh
# /sys/class/input/inputN where inputN/name is the keyboard
printf 1 | sudo tee /sys/class/input/input67/inhibited   # off
printf 0 | sudo tee /sys/class/input/input67/inhibited   # on
```

Devices are found by matching `inputN/name` exactly, then keeping only the
interfaces that report `EV_REP` (bit 20 — key autorepeat, which keyboards have
and pointers don't). That matters because one physical keyboard usually
registers several interfaces, and a plain "has EV_KEY" test would also match
your touchpad.

That needs root, so the extension shells out to `/usr/local/bin/kbd-internal-toggle`
via `pkexec`. The polkit action sets `allow_active=yes`: no password prompt for
whoever is physically logged in at this machine.

Nothing persists across a reboot, by design.

### Why not unbind atkbd?

The obvious approach — writing `serio0` to `/sys/bus/serio/drivers/atkbd/unbind`
— **does not work**, at least on this machine. The serio bus ships with
`bind_mode=auto`, so the core re-probes the port as soon as the driver lets go
and `atkbd` re-binds about a second later. The keyboard keeps working.

It's easy to misread as "the unbind failed". It didn't: the device really does
go away and come back. The tell is the input device returning under a *new*
`inputN` index — `input2` became `input67` here after one round trip.

Inhibit is better regardless: it's the kernel's purpose-built interface for
this, it has no re-probe race, and it isn't limited to i8042 keyboards.

## Why the helper isn't symlinked

Everything else in these dotfiles is symlinked, but `helper/install.sh` copies
its two files as root instead.

Not because pkexec forbids it — it doesn't. pkexec never calls `realpath()`, and
its only check on the target is `access(path, F_OK)`. A symlink into the repo
would run fine.

The reason is `allow_active=yes`. Passwordless root means the file pkexec
executes must not be writable by the user it grants root to, or anything running
as that user could append a line and escalate silently. Same goes for the
`.policy` file, which could otherwise be rewritten to authorise `/bin/sh`.

The repo stays the source of truth; `helper/install.sh check` reports when the
installed copies have drifted from it.

## Not getting locked out

Four guards, because a laptop with no working keyboard is genuinely annoying:

1. **Unplugging the external keyboard always re-enables the built-in one** —
   even with auto-disable off, and even if you flipped the switch by hand.
2. **Disabling or removing the extension re-enables it** on the way out.
3. `session-modes` includes `unlock-dialog`, so locking the screen doesn't tear
   the extension down, and unlocking doesn't trigger a spurious toggle.
4. **A reboot clears it**, since `inhibited` isn't persisted anywhere.

If something goes wrong anyway, recover from a TTY (`Ctrl+Alt+F3`), over SSH,
with the on-screen keyboard, or by rebooting:

```sh
sudo kbd-internal-toggle enable
```

## Install

The repo's top-level `install.sh` does the symlink and schema compile. The
privileged half is deliberately separate and has to be run once by hand:

```sh
./helper/install.sh
```

Manually, in full:

```sh
glib-compile-schemas schemas/
ln -s "$PWD" ~/.local/share/gnome-shell/extensions/keyboard-indicator@null-git
./helper/install.sh
# log out and back in -- Wayland has no shell restart
gnome-extensions enable keyboard-indicator@null-git
```

## Settings

No prefs dialog; two keys, read via `gsettings`:

```sh
sc=org.gnome.shell.extensions.keyboard-indicator
gsettings --schemadir schemas/ set $sc auto-disable true
gsettings --schemadir schemas/ set $sc internal-device-name 'AT Translated Set 2 keyboard'
```

`internal-device-name` must match `/sys/class/input/inputN/name` exactly (the
same string `/proc/bus/input/devices` shows as `N: Name=`). It does double duty:
it's the device to inhibit, and anything else is treated as external.

## Known limits

- **"Active" means connected, not last-typed-on.** Detecting which keyboard you
  most recently used means reading evdev directly, which means adding your user
  to the `input` group — that grants every process running as you keylogger-grade
  access to all input devices. Not worth it for two keyboards.
- **Name collisions.** Two keyboards reporting the exact same `name` would be
  inhibited together. Not a concern with one built-in and one external.
