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
augroup end
