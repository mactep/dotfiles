setlocal spelllang=en,pt spell

" breaking long lines into newer ones
setlocal tw=79 cc=80
" wrapping long lines
" setlocal wrap linebreak
" not using conceal as I started using reference style links
" setlocal cole=2

setlocal path+=$HOME/Dropbox/notes
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

hi! link markdownH2 Type
hi! link markdownH3 Number
hi! link markdownH4 Identifier
hi! link markdownH5 Statement
hi! link markdownH6 PreProc
hi! link markdownH7 Special

hi! link @text.title.1 markdownH1
hi! link @text.title.2 markdownH2
hi! link @text.title.3 markdownH3
hi! link @text.title.4 markdownH4
hi! link @text.title.5 markdownH5
hi! link @text.title.6 markdownH6
hi! link @text.title.7 markdownH7

hi! link @text.title.1.marker Operator
hi! link @text.title.2.marker Operator
hi! link @text.title.3.marker Operator
hi! link @text.title.4.marker Operator
hi! link @text.title.5.marker Operator
hi! link @text.title.6.marker Operator
hi! link @text.title.7.marker Operator
