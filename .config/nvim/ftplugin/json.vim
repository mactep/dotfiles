" TODO: convert to lua
let s:json_path_ns=luaeval("vim.api.nvim_create_namespace('json_path')")

function! s:show_json_path()
    let l:line_len=col('$')
    if l:line_len > 1000
        return
    endif
    let l:current_line=line('.')-1
    let l:json_path=luaeval('require"jsonpath".get()')
    let l:bufnr=bufnr('%')
    if exists('*nvim_buf_set_extmark')
        call nvim_buf_clear_namespace(l:bufnr, s:json_path_ns, 0, -1)
        call nvim_buf_set_extmark(l:bufnr, s:json_path_ns, l:current_line, 0, {"hl_group": "Comment", "hl_mode": "replace", "virt_text": [[l:json_path, 'json_path']], "virt_text_pos": "eol"})
    endif
endfunction

augroup json_path
    au!
    autocmd BufEnter,BufWritePost,CursorMoved *.json :call s:show_json_path()
augroup END
