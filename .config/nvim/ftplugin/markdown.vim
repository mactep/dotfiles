setlocal spelllang=en,pt-br spell 
setlocal path+=$HOME/Dropbox/notes

" breaking long lines into newer ones
" setlocal tw=79 cc=80
" setlocal cocu=nc cole=2

" wrapping long lines
setlocal wrap linebreak
setlocal cole=2

" ignores anchor at the end of the file name
" setlocal isfname-=#
" alternatively
" setlocal includeexpr=substitute(v:fname,'#\\w\\+','','g')

nnoremap <silent><buffer>gf :call MDGoToSection()<CR>

if exists('*MDGoToSection')
    finish
endif
function! MDGoToSection()
    let raw_filename = expand('<cfile>')
    let arg = substitute(raw_filename, '\([^#]*\)\(#\{1,6\}\)\([^#]*\)', '+\/\2\\\\s\3\\\\c \1', 'g')
    " TODO: handle spaced section names
    execute "edit" arg
endfunction

