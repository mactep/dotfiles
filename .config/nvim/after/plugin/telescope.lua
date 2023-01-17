local present, telescope = pcall(require, "telescope")
if not present then
	return
end

telescope.builtin = require("telescope.builtin")

local fb_actions = telescope.extensions.file_browser.actions
telescope.setup({
	defaults = {
		preview = {
			-- makes binary preview faster
			msg_bg_fillchar = " ",
		},
	},
	extensions = {
		file_browser = {
			hijack_netrw = true,
			initial_mode = "normal",
			respect_gitignore = true,
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

local find_files_hidden = function()
	telescope.builtin.find_files({ no_ignore = true })
end

local search_dotfiles = function()
	telescope.extensions.file_browser.file_browser({
		prompt_title = "NeoVimRC",
		cwd = vim.fn.stdpath("config"),
	})
end

local browse_blog = function()
	telescope.extensions.file_browser.file_browser({
		prompt_title = "Blog",
		cwd = "~/code/mactep.github.io/_posts",
	})
end

local find_wiki = function()
	telescope.builtin.find_files({
		prompt_title = "Find Wiki",
		cwd = "~/Dropbox/wiki",
		attach_mappings = function(_, map)
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

local explore_current_file_dir = function()
	local path = vim.fn.expand("%:p:h")
	telescope.extensions.file_browser.file_browser({
		prompt_title = "Explore current file directory",
		cwd = path,
	})
end

vim.keymap.set("n", "<leader>ff", telescope.builtin.find_files, { noremap = true })
vim.keymap.set("n", "<leader>fi", find_files_hidden, { noremap = true })
vim.keymap.set("n", "<leader>fr", telescope.builtin.live_grep, { noremap = true })
vim.keymap.set("n", "<leader>fh", telescope.builtin.help_tags, { noremap = true })
vim.keymap.set("n", "<leader>fB", telescope.builtin.buffers, { noremap = true })
vim.keymap.set("n", "<C-n>", telescope.extensions.file_browser.file_browser, { noremap = true })
vim.keymap.set("n", "<A-n>", explore_current_file_dir, { noremap = true })
vim.keymap.set("n", "<leader>fv", search_dotfiles, { noremap = true })
vim.keymap.set("n", "<leader>fb", browse_blog, { noremap = true })
vim.keymap.set("n", "<leader>fw", find_wiki, { noremap = true })
