" Oni-specific settings
if exists("g:gui_oni")
  " Turn off statusbar, because it is externalized
  set noshowmode
  set noruler
  set noshowcmd

  " v- Uncommnet when Oni handles splits correctly
  set laststatus=0

  " Enable GUI mouse behavior
  set mouse=a
endif
