setlocal spelllang=pt spell tw=79 cc=80

augroup tex
  au!
  au BufWinLeave *.tex silent execute '!latexmk -c'
  au BufWinLeave *.tex silent execute '!rm '.expand('%:r').'.synctex.gz'
augroup END

" format table
" !column -t -s \$ -o \$
