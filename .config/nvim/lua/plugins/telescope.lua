return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    local fb_actions = require("telescope").extensions.file_browser.actions

    local dropdown_configs = {
      layout_strategy = "vertical",
      layout_config = {
        prompt_position = "bottom",
        vertical = {
          width = 0.8,
          height = 100,
        },
      },
    }

    require("telescope").setup({
      defaults = {
        preview = {
          -- makes binary preview faster
          msg_bg_fillchar = " ",
        },
      },
      pickers = {
        buffers = {
          mappings = {
            -- i = {
            --   ["<c-d>"] = require("telescope.actions").delete_buffer,
            -- },
            n = {
              ["dd"] = require("telescope.actions").delete_buffer,
            },
          },
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
              ["<Alt-a>"] = fb_actions.create_from_prompt,
              ["J"] = fb_actions.create_from_prompt,
            },
            i = {
              ["<Alt-a>"] = fb_actions.create_from_prompt,
            },
          },
        },
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown(dropdown_configs),
      },
    })

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("file_browser")
    require("telescope").load_extension("ui-select")
  end,
  keys = {
    -- Find files
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files()
      end,
      { noremap = true, desc = "Find files" },
    },
    {
      "<leader>fi",
      function()
        require("telescope.builtin").find_files({ no_ignore = true })
      end,
      { noremap = true, desc = "Find files (no ignore)" },
    },
    {
      "<leader>fg",
      function()
        require("telescope.builtin").live_grep()
      end,
      { noremap = true, desc = "Grep files" },
    },
    {
      "<leader>fG",
      function()
        require("telescope.builtin").grep_string()
      end,
      { noremap = true, desc = "Grep for the string under cursor" },
    },
    {
      "<leader>fh",
      function()
        require("telescope.builtin").help_tags()
      end,
      { noremap = true, desc = "Find help" },
    },
    {
      "<leader>fb",
      function()
        require("telescope.builtin").buffers()
      end,
      { noremap = true, desc = "Find buffers" },
    },
    -- Neovim config
    {
      "<leader>fv",
      function()
        require("telescope").extensions.file_browser.file_browser({
          prompt_title = "NeoVimRC",
          cwd = vim.fn.stdpath("config"),
        })
      end,
      { noremap = true, desc = "Find files in NeoVim config" },
    },
    {
      "<leader>fV",
      function()
        require("telescope.builtin").find_files({
          prompt_title = "NeoVimRC",
          cwd = vim.fn.stdpath("config"),
        })
      end,
    },
    {
      "<leader>gv",
      function()
        require("telescope.builtin").live_grep({
          prompt_title = "NeoVimRC",
          cwd = vim.fn.stdpath("config"),
        })
      end,
    },
    {
      "<leader>fw",
      function()
        require("telescope.builtin").find_files({
          prompt_title = "Find wiki article",
          cwd = "~/Dropbox/wiki",
        })
      end,
    },
    {
      "<leader>fW",
      function()
        require("telescope.builtin").find_files({
          prompt_title = "Find wiki link",
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
      end,
    },
    {
      "<leader>fB",
      function()
        require("telescope").extensions.file_browser.file_browser({
          prompt_title = "Blog",
          cwd = "~/code/mactep.github.io/_posts",
        })
      end,
    },
    {
      "<C-n>",
      function()
        require("telescope").extensions.file_browser.file_browser()
      end,
    },
    {
      "<A-n>",
      function()
        require("telescope").extensions.file_browser.file_browser({
          prompt_title = "Explore current file directory",
          path = "%:p:h",
        })
      end,
    },
    -- Git objects
    {
      "<leader>gc",
      function()
        require("telescope.builtin").git_commits()
      end,
      { noremap = true, desc = "Git commits" },
    },
    {
      "<leader>gb",
      function()
        require("telescope.builtin").git_branches()
      end,
      { noremap = true, desc = "Git branches" },
    },
    {
      "<leader>gs",
      function()
        require("telescope.builtin").git_status()
      end,
      { noremap = true, desc = "Git status" },
    },
    {
      "<leader>gS",
      function()
        require("telescope.builtin").git_stash()
      end,
      { noremap = true, desc = "Git stash" },
    },
    {
      "<leader>gf",
      function()
        require("telescope.builtin").git_files()
      end,
      { noremap = true, desc = "Git files" },
    },
    {
      "<leader>gF",
      function()
        require("telescope.builtin").git_bcommits()
      end,
      { noremap = true, desc = "Git commits for current buffer" },
    },
  },
}
