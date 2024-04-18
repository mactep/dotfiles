-- Launches find_files in the directory under cursor
local find_inside_dir_under_cursor = function()
  local dir = require("oil").get_current_dir()
  local entry = require("oil").get_cursor_entry()
  if not entry or not dir then
    return
  end

  if entry.type == "directory" then
    dir = dir .. entry.name
  end

  require("oil").toggle_float()

  require("telescope.builtin").find_files({
    results_title = dir .. "/",
    cwd = dir,
  })
end

-- Launches live_grep in the directory under cursor
local grep_dir_under_cursor = function()
  local dir = require("oil").get_current_dir()
  local entry = require("oil").get_cursor_entry()
  if not entry or not dir then
    return
  end

  if entry.type == "directory" then
    dir = dir .. entry.name
  end

  require("oil").toggle_float()

  require("telescope").extensions.live_grep_args.live_grep_args({
    results_title = dir .. "/",
    cwd = dir,
  })
end

return {
  {
    "NTBBloodbath/rest.nvim",
    name = "rest-nvim",
    opts = {
      result_split_horizontal = false,
    },
    ft = { "http", },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    enabled = false,
    "mactep/silicon.lua",
    dir = "~/code/silicon.lua",
    opts = {
      -- theme = "catppuccin",
      output = "",
      -- font = "JetBrains Mono",
    },
    keys = {
      {
        "<leader>s",
        function()
          require("silicon").visualise_api({ to_clip = true })
        end,
        mode = "v",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "lambdalisue/suda.vim",
    event = "VeryLazy",
    config = function()
      vim.g.suda_smart_edit = 1
    end,
  },
  {
    enabled = false,
    "stevearc/oil.nvim",
    opts = {
      keymaps = {
        -- mimic telescope's keymaps
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-x>"] = "actions.select_split",
        ["<C-f>"] = find_inside_dir_under_cursor,
        ["<C-g>"] = grep_dir_under_cursor,
      },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("User", {
        group = vim.api.nvim_create_augroup("oil", {}),
        pattern = "OilEnter",
        callback = vim.schedule_wrap(function(args)
          local oil = require("oil")
          if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
            oil.select({ preview = true })
          end
        end),
      })
      require("oil").setup(opts)
    end,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<C-n>",
        function()
          require("oil").toggle_float(vim.fn.getcwd())
        end,
      },
      -- File browser relative to current file
      {
        "<A-n>",
        function()
          require("oil").toggle_float()
        end,
      },
    },
  }
}
