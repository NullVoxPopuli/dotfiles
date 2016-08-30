# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

##################################################
# Force Vim Mode Plus to be in normal mode on blur
##################################################
toNormalMode = 'vim-mode-plus:reset-normal-mode'
selector = 'atom-text-editor.vim-mode-plus:not(.normal-mode)'

atom.commands.add selector, 'blur', ->
  atom.commands.dispatch(this, toNormalMode)
