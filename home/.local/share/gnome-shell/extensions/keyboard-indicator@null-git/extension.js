/**
 * Keyboard Indicator
 * Shows which keyboards are connected and lets you inhibit the built-in one.
 * License GPL v3
 */

import Clutter from "gi://Clutter";
import Gio from "gi://Gio";
import GLib from "gi://GLib";
import GObject from "gi://GObject";
import St from "gi://St";

import * as Main from "resource:///org/gnome/shell/ui/main.js";
import * as PopupMenu from "resource:///org/gnome/shell/ui/popupMenu.js";
import { Button } from "resource:///org/gnome/shell/ui/panelMenu.js";
import { Extension } from "resource:///org/gnome/shell/extensions/extension.js";

const HELPER = "/usr/local/bin/kbd-internal-toggle";
const INPUT_CLASS = "/sys/class/input";

// EV_REP: key autorepeat, which real keyboards have and pointers don't
const EV_REP = 0x100000;

// libinput reports plenty of things as keyboards that nobody types on
const NOT_A_KEYBOARD =
  /power button|lid switch|sleep button|video bus|wireless radio|consumer control|system control|hdmi|headphone|touchpad|mouse/i;

// a single USB keyboard registers several HID interfaces, so coalesce the burst
const SETTLE_MS = 300;

// sysfs takes a moment to catch up after a toggle
const TOGGLE_SETTLE_MS = 400;

/**
 * @param {string} path
 * @returns {string|null} trimmed contents, or null if unreadable
 */
function read_sysfs(path) {
  try {
    const [ok, bytes] = GLib.file_get_contents(path);
    return ok ? new TextDecoder().decode(bytes).trim() : null;
  } catch {
    return null;
  }
}

/**
 * sysfs nodes for the keyboard interfaces of the device with this exact name.
 * One physical keyboard usually exposes several, only some of them keyboards.
 * @param {string} name
 * @returns {string[]}
 */
function input_nodes_named(name) {
  const nodes = [];

  let children;
  try {
    children = Gio.File.new_for_path(INPUT_CLASS).enumerate_children(
      "standard::name",
      Gio.FileQueryInfoFlags.NONE,
      null,
    );
  } catch {
    return nodes;
  }

  let info;
  while ((info = children.next_file(null))) {
    const dir = `${INPUT_CLASS}/${info.get_name()}`;
    if (read_sysfs(`${dir}/name`) !== name) {
      continue;
    }
    const ev = read_sysfs(`${dir}/capabilities/ev`);
    if (!ev || !(parseInt(ev.split(" ").pop(), 16) & EV_REP)) {
      continue;
    }
    nodes.push(dir);
  }

  return nodes;
}

/**
 * @param {string} name
 * @returns {"enabled"|"disabled"|"absent"}
 */
function internal_state(name) {
  const nodes = input_nodes_named(name);
  if (nodes.length === 0) {
    return "absent";
  }
  return nodes.every((dir) => read_sysfs(`${dir}/inhibited`) === "1")
    ? "disabled"
    : "enabled";
}

/**
 * strip the boilerplate vendors pad device names with
 * @param {string} name
 * @returns {string}
 */
function short_name(name) {
  const cleaned = name
    .replace(/\b(usb|device|keyboard|kbd|wireless|receiver|composite|hid)\b/gi, " ")
    .replace(/\s+/g, " ")
    .trim();
  return cleaned || name;
}

/**
 * every physical keyboard the seat currently knows about, one entry per
 * physical device (HID interfaces of the same keyboard collapse together)
 * @returns {{name: string, id: string}[]}
 */
function list_keyboards() {
  const seat = Clutter.get_default_backend().get_default_seat();
  const found = new Map();

  for (const device of seat.list_devices()) {
    if (device.get_device_type() !== Clutter.InputDeviceType.KEYBOARD_DEVICE) {
      continue;
    }

    const name = device.get_device_name();
    if (NOT_A_KEYBOARD.test(name)) {
      continue;
    }

    const vendor = device.get_vendor_id?.();
    const product = device.get_product_id?.();
    const id = vendor && product ? `${vendor}:${product}` : name;

    // keep the shortest name of the group: "SONIX USB DEVICE" over
    // "SONIX USB DEVICE Keyboard"
    const existing = found.get(id);
    if (!existing || name.length < existing.name.length) {
      found.set(id, { name, id });
    }
  }

  return [...found.values()];
}

const KeyboardIndicator = GObject.registerClass(
  class KeyboardIndicator extends Button {
    /**
     * @param {Gio.Settings} settings
     * @private
     */
    _init(settings) {
      super._init(0.5, "Keyboard Indicator");
      this._settings = settings;
      this._settle_id = 0;
      this._toggle_id = 0;
      this._applying = false;

      const box = new St.BoxLayout({ style_class: "panel-status-menu-box" });
      this._icon = new St.Icon({
        icon_name: "input-keyboard-symbolic",
        style_class: "system-status-icon",
      });
      this._label = new St.Label({
        y_align: Clutter.ActorAlign.CENTER,
        style_class: "keyboard-indicator-label",
      });
      box.add_child(this._icon);
      box.add_child(this._label);
      this.add_child(box);

      this._build_menu();

      this._seat = Clutter.get_default_backend().get_default_seat();
      this._device_added = this._seat.connect("device-added", () => this._schedule_refresh());
      this._device_removed = this._seat.connect("device-removed", () => this._schedule_refresh());
      this._auto_changed = this._settings.connect("changed::auto-disable", () => this._refresh());

      // a toggle done outside the extension won't signal us
      this.menu.connect("open-state-changed", (_menu, open) => {
        if (open) {
          this._refresh();
        }
      });

      this._refresh();
    }

    /**
     * remove signals and pending timeouts
     * @public
     */
    _destroy() {
      if (this._settle_id) {
        GLib.Source.remove(this._settle_id);
        this._settle_id = 0;
      }
      if (this._toggle_id) {
        GLib.Source.remove(this._toggle_id);
        this._toggle_id = 0;
      }
      if (this._device_added) {
        this._seat.disconnect(this._device_added);
      }
      if (this._device_removed) {
        this._seat.disconnect(this._device_removed);
      }
      if (this._auto_changed) {
        this._settings.disconnect(this._auto_changed);
      }
      super.destroy();
    }

    /**
     * @private
     */
    _build_menu() {
      this._devices_section = new PopupMenu.PopupMenuSection();
      this.menu.addMenuItem(this._devices_section);
      this.menu.addMenuItem(new PopupMenu.PopupSeparatorMenuItem());

      this._internal_switch = new PopupMenu.PopupSwitchMenuItem("Built-in keyboard", true);
      this._internal_toggled = this._internal_switch.connect("toggled", (_item, state) => {
        this._set_internal(state);
      });
      this.menu.addMenuItem(this._internal_switch);

      this._auto_switch = new PopupMenu.PopupSwitchMenuItem(
        "Auto-disable when external connected",
        this._settings.get_boolean("auto-disable"),
      );
      this._auto_toggled = this._auto_switch.connect("toggled", (_item, state) => {
        this._settings.set_boolean("auto-disable", state);
      });
      this.menu.addMenuItem(this._auto_switch);

      this._warning = new PopupMenu.PopupMenuItem("Helper not installed", { reactive: false });
      this._warning.label.add_style_class_name("keyboard-indicator-warning");
      this.menu.addMenuItem(this._warning);
    }

    /**
     * @returns {"enabled"|"disabled"|"absent"}
     * @private
     */
    _internal_state() {
      return internal_state(this._settings.get_string("internal-device-name"));
    }

    /**
     * device events arrive in bursts, so wait for them to stop
     * @private
     */
    _schedule_refresh() {
      if (this._settle_id) {
        GLib.Source.remove(this._settle_id);
      }
      this._settle_id = GLib.timeout_add(GLib.PRIORITY_DEFAULT, SETTLE_MS, () => {
        this._settle_id = 0;
        this._refresh();
        return GLib.SOURCE_REMOVE;
      });
    }

    /**
     * re-read device state, apply the auto policy, redraw
     * @private
     */
    _refresh() {
      const internal_name = this._settings.get_string("internal-device-name");
      const state = this._internal_state();
      const externals = list_keyboards().filter((kbd) => kbd.name !== internal_name);

      this._render(internal_name, state, externals);

      if (this._applying || state === "absent") {
        return;
      }

      // safety first: never leave the machine with no keyboard at all
      if (externals.length === 0 && state === "disabled") {
        this._set_internal(true);
        return;
      }

      if (
        this._settings.get_boolean("auto-disable") &&
        externals.length > 0 &&
        state === "enabled"
      ) {
        this._set_internal(false);
      }
    }

    /**
     * @param {string} internal_name
     * @param {"enabled"|"disabled"|"absent"} state
     * @param {{name: string, id: string}[]} externals
     * @private
     */
    _render(internal_name, state, externals) {
      const enabled = state === "enabled";

      if (externals.length === 0) {
        this._label.set_text("Built-in");
      } else if (enabled) {
        this._label.set_text("Both");
      } else {
        this._label.set_text(short_name(externals[0].name));
      }

      // no stock "keyboard off" icon exists, so dim the panel icon instead
      if (enabled) {
        this._icon.remove_style_class_name("keyboard-indicator-icon-muted");
      } else {
        this._icon.add_style_class_name("keyboard-indicator-icon-muted");
      }

      this._devices_section.removeAll();
      for (const kbd of externals) {
        this._devices_section.addMenuItem(this._device_item(kbd.name, "enabled"));
      }
      this._devices_section.addMenuItem(
        this._device_item(internal_name, state === "absent" ? "absent" : state),
      );

      // setToggleState() emits "toggled", which would re-enter the click
      // handler. _set_internal() re-reads sysfs and would no-op, but don't
      // rely on that -- block the handlers while syncing the UI to reality.
      this._internal_switch.block_signal_handler(this._internal_toggled);
      this._internal_switch.setToggleState(enabled);
      this._internal_switch.unblock_signal_handler(this._internal_toggled);

      this._auto_switch.block_signal_handler(this._auto_toggled);
      this._auto_switch.setToggleState(this._settings.get_boolean("auto-disable"));
      this._auto_switch.unblock_signal_handler(this._auto_toggled);

      this._internal_switch.setSensitive(this._helper_installed() && state !== "absent");
      this._warning.visible = !this._helper_installed();
    }

    /**
     * one read-only "name .... state" row
     * @param {string} name
     * @param {string} state
     * @returns {PopupMenu.PopupMenuItem}
     * @private
     */
    _device_item(name, state) {
      const item = new PopupMenu.PopupMenuItem(short_name(name), { reactive: false });
      const status = new St.Label({
        text: state,
        y_align: Clutter.ActorAlign.CENTER,
        x_align: Clutter.ActorAlign.END,
        x_expand: true,
        style_class: `keyboard-indicator-state keyboard-indicator-${state}`,
      });
      item.add_child(status);
      return item;
    }

    /**
     * @returns {boolean}
     * @private
     */
    _helper_installed() {
      return GLib.file_test(HELPER, GLib.FileTest.IS_EXECUTABLE);
    }

    /**
     * inhibit or un-inhibit the built-in keyboard through the privileged helper
     * @param {boolean} enabled
     * @private
     */
    _set_internal(enabled) {
      const state = this._internal_state();
      if (this._applying || state === "absent" || (state === "enabled") === enabled) {
        return;
      }
      if (!this._helper_installed()) {
        console.error(`keyboard-indicator: ${HELPER} is not installed`);
        this._refresh();
        return;
      }

      this._applying = true;
      const action = enabled ? "enable" : "disable";
      const name = this._settings.get_string("internal-device-name");

      let proc;
      try {
        proc = Gio.Subprocess.new(
          ["pkexec", HELPER, action, name],
          Gio.SubprocessFlags.STDOUT_PIPE | Gio.SubprocessFlags.STDERR_PIPE,
        );
      } catch (error) {
        console.error(`keyboard-indicator: could not run helper: ${error}`);
        this._applying = false;
        this._refresh();
        return;
      }

      proc.communicate_utf8_async(null, null, (source, result) => {
        try {
          const [, , stderr] = source.communicate_utf8_finish(result);
          if (!source.get_successful()) {
            console.error(`keyboard-indicator: ${action} failed: ${stderr.trim()}`);
          }
        } catch (error) {
          console.error(`keyboard-indicator: ${action} failed: ${error}`);
        }

        // let sysfs and the seat catch up before believing what we read
        if (this._toggle_id) {
          GLib.Source.remove(this._toggle_id);
        }
        this._toggle_id = GLib.timeout_add(GLib.PRIORITY_DEFAULT, TOGGLE_SETTLE_MS, () => {
          this._toggle_id = 0;
          this._applying = false;
          this._refresh();
          return GLib.SOURCE_REMOVE;
        });
      });
    }

    /**
     * best-effort restore, so a disabled extension never strands you
     * @public
     */
    _restore_internal() {
      if (this._internal_state() !== "disabled" || !this._helper_installed()) {
        return;
      }
      const name = this._settings.get_string("internal-device-name");
      try {
        Gio.Subprocess.new(["pkexec", HELPER, "enable", name], Gio.SubprocessFlags.NONE);
      } catch (error) {
        console.error(`keyboard-indicator: could not restore built-in keyboard: ${error}`);
      }
    }
  },
);

// noinspection JSUnusedGlobalSymbols
export default class KeyboardIndicatorExtension extends Extension {
  enable() {
    this._indicator = new KeyboardIndicator(this.getSettings());
    Main.panel.addToStatusArea("keyboard-indicator", this._indicator, 0, "right");
  }

  disable() {
    this._indicator._restore_internal();
    this._indicator._destroy();
    this._indicator = null;
  }
}
