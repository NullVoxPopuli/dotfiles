" http://stackoverflow.com/a/6052704/356849
fu! SaveSess()
    execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction

fu! RestoreSess()
if filereadable(getcwd() . '/.session.vim')
    execute 'so ' . getcwd() . '/.session.vim'
    if bufexists(1)
        for l in range(1, bufnr('$'))
            if bufwinnr(l) == -1
                exec 'sbuffer ' . l
            endif
        endfor
    endif
endif
syntax on
endfunction

" Save session on quitting Vim
" autocmd VimLeave * NERDTreeTabsClose
" autocmd VimLeave * call SaveSess()

" Restore session on starting Vim
" autocmd VimEnter * call RestoreSess()
" NERDTree is loaded in plugin-config.vim
