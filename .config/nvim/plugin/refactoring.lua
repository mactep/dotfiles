local present, refactor = pcall(require, "refactoring")
if present then
	refactor.setup({})

	vim.api.nvim_set_keymap(
		"v",
		"<Leader>re",
		[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
		{ noremap = true, silent = true, expr = false }
	)
	vim.api.nvim_set_keymap(
		"v",
		"<Leader>rf",
		[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
		{ noremap = true, silent = true, expr = false }
	)
	vim.api.nvim_set_keymap(
		"v",
		"<leader>rv",
		[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
		{ noremap = true, silent = true, expr = false }
	)
	vim.api.nvim_set_keymap(
		"v",
		"<leader>ri",
		[[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
		{ noremap = true, silent = true, expr = false }
	)

	vim.api.nvim_set_keymap(
		"v",
		"<leader>rr",
		":lua require('refactoring').select_refactor()<CR>",
		{ noremap = true, silent = true, expr = false }
	)

	vim.api.nvim_set_keymap(
		"n",
		"<leader>rp",
		":lua require('refactoring').debug.printf({below = false})<CR>",
		{ noremap = true }
	)

	vim.api.nvim_set_keymap(
		"v",
		"<leader>rv",
		":lua require('refactoring').debug.print_var({})<CR>",
		{ noremap = true }
	)

	vim.api.nvim_set_keymap(
        "n",
        "<leader>rc",
        ":lua require('refactoring').debug.cleanup({})<CR>",
        { noremap = true }
    )
end
