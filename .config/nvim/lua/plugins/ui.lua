return {
  {
    "lukas-reineke/indent-blankline.nvim",
    -- event = "BufRead",
    event = "BufRead",
    opts = {
      show_current_context = true,
      buftype_exclude = { "terminal" },
      filetype_exclude = { "NvimTree" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "phelipetls/jsonpath.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer" },
    config = true,
  },
  {
    "kyazdani42/nvim-web-devicons",
    lazy = false,
  },
  {
    "stevearc/dressing.nvim",
    lazy = false,
    opts = {
      input = {
        get_config = function(opts)
          if opts.prompt == "New Name: " then
            return {
              start_in_insert = false,
            }
          elseif opts.completion == "file" then
            -- better position
            return {
              relative = "editor",
              start_in_insert = false,
            }
          end
        end,
      },
      select = {
        get_config = function(opts)
          if opts.kind == "codeaction" then
            opts = {
              -- opens telescope at cursor position
              telescope = require("telescope.themes").get_cursor(),
            }
            -- sort null-ls actions last
            opts.telescope.sorter = require('telescope.sorters').Sorter:new {
                scoring_function = function(_, _, line)
                  if string.match(line, 'null-ls') then
                    return 0
                  else
                    return 1
                  end
                end,
              }

            return opts
          end
        end,
      },
    },
  },
}
