return {
	"ThePrimeagen/refactoring.nvim",
	config = {
		prompt_func_return_type = {
			go = true,
		},
		prompt_func_param_type = {
			go = true,
		},
	},
	keys = {
		{
			"<leader>rr",
			function()
				if pcall(require, "telescope") then
					require("telescope").extensions.refactoring.refactors()
				else
					require("refactoring").select_refactor()
				end
			end,
      mode = "v",
		},
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-lua/plenary.nvim",
	},
}
