local present, telescope = pcall(require, "telescope")
if present then
	local fb_actions = telescope.extensions.file_browser.actions
	telescope.setup({
		defaults = {
			preview = {
				-- makes telescope more responsive
				msg_bg_fillchar = " ",
			},
		},
		extensions = {
			file_browser = {
				initial_mode = "normal",
				mappings = {
					n = {
						["l"] = "select_default",
						["h"] = fb_actions.goto_parent_dir,
						["H"] = fb_actions.toggle_hidden,
						["<Tab>"] = "toggle_selection",
						["a"] = fb_actions.create,
					},
				},
			},
		},
	})

	telescope.load_extension("fzf")
	telescope.load_extension("file_browser")

	search_dotfiles = function()
		telescope.extensions.file_browser.file_browser({
			prompt_title = "NeoVimRC",
			cwd = vim.fn.stdpath("config"),
		})
	end

	browse_blog = function()
		telescope.extensions.file_browser.file_browser({
			prompt_title = "Blog",
			cwd = "~/code/mactep.github.io/_posts",
		})
	end

	find_wiki = function()
		require("telescope.builtin").find_files({
			prompt_title = "Find Wiki",
			cwd = "~/Dropbox/wiki",
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

	vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true })
	vim.api.nvim_set_keymap("n", "<leader>fr", "<cmd>Telescope live_grep<cr>", { noremap = true })
	vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { noremap = true })
	vim.api.nvim_set_keymap("n", "<C-n>", "<cmd>Telescope file_browser<cr>", { noremap = true })
	vim.api.nvim_set_keymap("n", "<leader>fB", "<cmd>Telescope buffers<cr>", { noremap = true })
	vim.api.nvim_set_keymap("n", "<leader>fv", "<cmd>lua search_dotfiles()<cr>", { noremap = true })
	vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua browse_blog()<cr>", { noremap = true })
	vim.api.nvim_set_keymap("n", "<leader>fw", "<cmd>lua find_wiki()<cr>", { noremap = true })
end
