setlocal spelllang=pt spell tw=79 cc=80

augroup tex
  au!
  au BufWritePost *.tex call jobstart('!tectonic --synctex --keep-logs --keep-intermediates '.expand('%'))
  au BufWinLeave *.tex silent execute '!latexmk -c'
  au BufWinLeave *.tex silent execute '!rm '.expand('%:r').'.synctex.gz'
  au BufWinLeave *.tex silent execute '!rm '.expand('%:r').'.aux '.expand('%:r').'.log'
augroup END

command! -range=% -nargs=0 FormatTable :<line1>,<line2>!column -t -s \& -o \&

function! OpenZathura()
    let position = line('.') . ":" . col('.') . ":" . expand('%:p') . " "
    call jobstart("zathura -x 'nvr --remote +%{line} %{input}' --synctex-forward " . position . " " . substitute(expand('%:p'),"tex$","pdf", ""))
endfunction
map <leader><Enter> :call OpenZathura()<cr>
