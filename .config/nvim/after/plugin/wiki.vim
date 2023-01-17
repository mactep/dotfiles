let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{
    \ 'path': '~/Dropbox/wiki/',
    \ 'syntax': 'markdown',
    \ 'ext': '.md',
    \ 'custom_wiki2html': '~/Dropbox/wiki/wiki2html.sh',
    \ 'path_html': '~/Dropbox/wiki_html/',
    \ 'template_path': '~/Dropbox/wiki/templates/',
\}]

let g:vimwiki_key_mappings = { 'table_mappings': 0 }

augroup vimwikigroup
    autocmd!
    autocmd BufRead,BufNewFile diary.md VimwikiDiaryGenerateLinks
    autocmd BufNewFile ~/Dropbox/wiki/diary/*.md
        \ call append(0,[
        \ "# " . strftime("%d/%m/%Y"), "",
        \ "## Todo",  "",
        \ "## Notes"])
    autocmd BufRead ~/Dropbox/wiki/diary/*.md
                \ iab <buffer><expr> dt strftime("%c") |
                \ iab <buffer><expr> ds "start: " . strftime("%c") |
                \ iab <buffer><expr> df "finish: " . strftime("%c") |
augroup end

let g:taskwiki_dont_fold = 1
