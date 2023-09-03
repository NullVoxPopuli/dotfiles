" https://neovide.dev/configuration.html
if exists("g:neovide")
  let g:neovide_cursor_animation_length=0.01
  let g:neovide_cursor_trail_length=0.01

  " VFX disabled
  let g:neovide_cursor_vfx_mode = ""
  " let g:neovide_cursor_vfx_mode = "pixiedust"
  let g:nenvide_cursor_vfx_opacity = 2000.0
  let g:neovide_cursor_vfx_particle_lifetime = 1.0
  let g:neovide_cursor_vfx_particle_density = 10.0
  set guifont=DejaVuSansMono_Nerd_Font_Mono:h11
endif
