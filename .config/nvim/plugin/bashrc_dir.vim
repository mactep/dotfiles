  augroup bashrcdgroup
      autocmd!
      autocmd BufRead,BufNewFile ~/.bashrc.d/* setlocal filetype=bash
  augroup end
