" resizes splits equally after resizing vim
augroup autoresize
    autocmd!
    autocmd VimResized * wincmd =
augroup END
