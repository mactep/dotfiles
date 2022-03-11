new_zk = function(...)
	local sep = ""
	if #... > 0 then
		sep = "_"
	end
	local words = {}
	for i = 1, select("#", ...) do
		local v = select(i, ...)
		table.insert(words, v)
	end
	local args = table.concat(words, "_")
	local file_name = vim.fn.resolve(os.getenv("ZK_PATH") .. "/" .. os.date("%Y%m%d%H%M") .. sep .. args .. ".md")
	vim.cmd("e " .. file_name)
    vim.cmd("normal ggO# " .. table.concat(words, " "))
    vim.cmd("normal o")
    vim.cmd("normal G")
end

vim.cmd([[command! -nargs=* Zk lua new_zk(<f-args>)]])

local present, _ = pcall(require, "telescope")
if not present then
	return
end

search_zk = function()
	require("telescope.builtin").find_files({
		prompt_title = "Notes",
		cwd = "$ZK_PATH",
	})
end

grep_zk = function()
	require("telescope.builtin").live_grep({
		prompt_title = "grep notes",
		cwd = "$ZK_PATH",
	})
end

browse_zk = function()
	require("telescope").extensions.file_browser.file_browser({
		prompt_title = "Notes",
		cwd = "$ZK_PATH",
		attach_mappings = function(prompt_bufnr, map)
			local action_state = require("telescope.actions.state")
			local create_new_file = function()
				local file = action_state.get_current_line()
				if file == "" then
					return
				end
				require("telescope.actions").close(prompt_bufnr)
                new_zk(file)
			end

			map("i", "<C-e>", create_new_file)
			map("n", "<C-e>", create_new_file)
			return true
		end,
	})
end

find_link = function()
	require("telescope.builtin").find_files({
		prompt_title = "Find Wiki",
		cwd = "$ZK_PATH",
		attach_mappings = function(prompt_bufnr, map)
			map("i", "<CR>", function(prompt_bufnr)
				-- filename is available at entry[1]
				local entry = require("telescope.actions.state").get_selected_entry()
				require("telescope.actions").close(prompt_bufnr)
				local filename = entry[1]
				-- Insert filename in current cursor position
				vim.cmd("normal i[" .. filename .. "](" .. filename .. ")")
			end)

			return true
		end,
	})
end

vim.api.nvim_set_keymap("n", "<leader>zf", "<cmd>lua search_zk()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>zg", "<cmd>lua grep_zk()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>zb", "<cmd>lua browse_zk()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>zl", "<cmd>lua find_link()<cr>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-l>", "<cmd>lua find_link()<cr>", { noremap = true })
