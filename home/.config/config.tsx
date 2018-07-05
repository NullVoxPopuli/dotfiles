
import * as React from "/opt/Oni/resources/app/node_modules/react"
import * as Oni from "/opt/Oni/resources/app/node_modules/oni-api"

interface ISidebar {
    sidebar: {
        activeEntryId: string
        isFocused: boolean
    }
}

export const activate = (oni: Oni.Plugin.Api) => {
    console.log("config activated")

    const leader = "'";

    ///////////////////////////////
    // Variables stolen from:
    // https://github.com/onivim/oni/blob/master/browser/src/Input/KeyBindings.ts
    const { editors, input, menu } = oni;

    const isVisualMode = () => editors.activeEditor.mode === "visual"
    const isNormalMode = () => editors.activeEditor.mode === "normal"
    const isInsertMode = () => editors.activeEditor.mode === 'insert'
    const isNotInsertMode = () => !isInsertMode();

    const isInsertOrCommandMode = () => (isInsertMode() || editors.activeEditor.mode === "cmdline_normal")

    const oniWithSidebar = oni as Oni.Plugin.Api & ISidebar
    const isExplorerActive = () =>
        oniWithSidebar.sidebar.activeEntryId === "oni.sidebar.explorer" &&
        oniWithSidebar.sidebar.isFocused &&
        !isInsertOrCommandMode() &&
        !isMenuOpen()

    const isMenuOpen = () => menu.isMenuOpen()

    /////////////////////////////////////
    // Configure the underlying neovim
    const vimrc = (cmd: string) => editors.activeEditor.neovim.command(cmd);
    
    // use a leader key that is easier to reach for DVorak
    vimrc(`let mapleader = "${leader}"`);
    vimrc(`let maplocaleader = "${leader}"`);

    // use Semicolon instead of colon for commands. Less keystrokes
    vimrc(`nnoremap ; :`);

    // swap navigation keys for more ergonomic navigation
    // querty: h j k l -- left down up right (inline)
    // dvorak: h t c n -- left down up right (WASD)
    //
    // consider http://vimcasts.org/blog/2013/02/habit-breaking-habit-making/
    // 
    


    /////////////////////////////////////
    // Actual Key bindings here
    // starting with general / global-ish keybindings
    input.unbind("<c-t>")
    input.bind("<c-t>", "quickOpen.show")


    // Sidebar Management
    input.bind(`${leader}l`, 'sidebar.toggle')
    input.bind(`${leader}n`, 'sidebar.increaseWidth')
    input.bind(`${leader}h`, 'sidebar.decreaseWidth')

    /////////////////////////////////////////
    // Window / Buffer Management / Navigation



    //
    // Or remove the default bindings here by uncommenting the below line:
    //
    // oni.input.unbind("<c-p>")

    // Browser
    input.bind("c", "browser.scrollUp")
    input.bind("t", "browser.scrollDown")
    input.bind("h", "browser.scrollLeft")
    input.bind("n", "browser.scrollRight")

}

export const deactivate = (oni: Oni.Plugin.Api) => {
    console.log("config deactivated")
}

export const configuration = {
    //add custom config here, such as

    //"oni.useDefaultConfig": true,
    "oni.bookmarks": ["~/Development"],
    //"oni.loadInitVim": false,
    "oni.exclude": [
      "node_modules",
      ".git",
      "dist",
      "tmp"
    ],
    //"editor.fontSize": "12px",
    //"editor.fontFamily": "Monaco",

    // UI customizations
    "tabs.height": "1.5em",
    "ui.colorscheme": "nord",
    "ui.animations.enabled": true,
    "ui.fontSmoothing": "auto",
}
