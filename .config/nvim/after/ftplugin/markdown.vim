setlocal spelllang=en,pt spell
setlocal path+=$HOME/Dropbox/notes

" breaking long lines into newer ones
setlocal tw=79 cc=80
" wrapping long lines
setlocal wrap linebreak
setlocal cole=2

" ignores anchor at the end of the file name
" setlocal isfname-=#
" alternatively
" setlocal includeexpr=substitute(v:fname,'#\\w\\+','','g')

nnoremap <silent><buffer>gF :call MDGoToSection()<CR>

if exists('*MDGoToSection')
    finish
endif

" Go to file under cursor. If the filename has a section name, go to that section.
function! MDGoToSection()
    let dir = expand('%:p:h')
    let raw_filename = dir . '/' . expand('<cfile>')

    let arg = substitute(raw_filename, '\([^#]*\)\(#\{1,6\}\)\([^#]*\)', '+\/\2\\\\s\3\\\\c \1', 'g')
    " TODO: handle spaced section names
    execute "edit" arg
endfunction
