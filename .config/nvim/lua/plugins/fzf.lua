vim.api.nvim_command([[ tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>" ]])
vim.api.nvim_command('nnoremap <C-n> :GFiles<CR>')
vim.api.nvim_command('nnoremap <leader>b :Buffers<CR>')

vim.api.nvim_command("let $FZF_DEFAULT_OPTS = '--reverse'")

-- ignore some files
vim.cmd(
  [[ command! -bang -nargs=* Rg ]] ..
  [[   call fzf#vim#grep( ]] ..
  [[   "rg --column --line-number --no-heading --color=always --smart-case -g '!package-lock.json' -g '!node_modules' -- ".shellescape(<q-args>), 1, ]] ..
  [[   fzf#vim#with_preview(), <bang>0) ]]
)

vim.cmd([[
  function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
  endfunction

  command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
]])
