return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>G",
        function()
          local actions = require("gitsigns").get_actions()
          actions["stage_buffer"] = function()
            require("gitsigns").stage_buffer()
          end
          actions["blame_line"] = nil

          local actions_keys = vim.tbl_keys(actions)
          vim.ui.select(
            actions_keys,
            {
              prompt = "Gitsigns",
            },
            function(choice)
              actions[choice]()
            end
          )
        end,
      },
      {
        "<leader>gs",
        function()
          require("gitsigns").stage_hunk()
        end,
      },
      {
        "]c",
        function()
          require("gitsigns").next_hunk()
        end,
      },
      {
        "[c",
        function()
          require("gitsigns").prev_hunk()
        end,
      },
    },
    opts = {
      numhl = true,
      signcolumn = false,
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
      "DiffviewClose",
    },
    opts = {
      enhanced_diff_hl = true,
      hooks = {
        view_opened = function()
          vim.opt_local.hidden = true
        end,
        diff_buf_read = function(bufnr)
          vim.opt_local.wrap = true
          vim.opt_local.list = false
        end
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "NeogitOrg/neogit",
    cmd = {
      "Neogit",
    },
    keys = {
      {
        "<leader>gg",
        function()
          require("neogit").open()
        end,
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
    },
    opts = {
    },
    config = function(opts)
      require("neogit").setup(opts)

      local group = vim.api.nvim_create_augroup("MyCustomNeogitEvents", {})
      vim.api.nvim_create_autocmd("User", {
        pattern = "NeogitPushComplete",
        group = group,
        callback = function()
          require("git_remote").open_pr_url()
        end
      })
    end,
  },
  {
    dir = "~/.config/nvim/git_remote/",
    name = "git_remote",
    cmd = {
      "RemoteFileURL",
      "OpenPRURL",
    },
  },
  {
    "FabijanZulj/blame.nvim",
    cmd = {
      "ToggleBlame",
      "EnableBlame",
      "DisableBlame",
    },
  },
}
