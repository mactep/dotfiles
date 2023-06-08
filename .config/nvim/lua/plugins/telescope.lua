-- Drops the selected stash
-- @param prompt_bufnr number: The prompt bufnr
local git_drop_stash = function(prompt_bufnr)
  local action_state = require("telescope.actions.state")
  local utils = require("telescope.utils")
  local actions = require("telescope.actions")

  local selection = action_state.get_selected_entry()
  if selection == nil then
    utils.__warn_no_selection "actions.git_drop_stash"
    return
  end
  actions.close(prompt_bufnr)
  local _, ret, stderr = utils.get_os_command_output { "git", "stash", "drop", selection.value }
  if ret == 0 then
    utils.notify("actions.git_drop_stash", {
      msg = string.format("dropped: '%s' ", selection.value),
      level = "INFO",
    })
  else
    utils.notify("actions.git_drop_stash", {
      msg = string.format("Error when droping: %s. Git returned: '%s'", selection.value, table.concat(stderr, " ")),
      level = "ERROR",
    })
  end
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-file-browser.nvim",
    -- "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    local fb_actions = require("telescope").extensions.file_browser.actions

    require("telescope").setup({
      defaults = {
        preview = {
          -- makes binary preview faster
          msg_bg_fillchar = " ",
        },
        path_display = { "truncate" },
        layout_strategy = "flex",
        layout_config = {
          vertical = { height = 0.95, width = 0.95 },
          horizontal = {
            prompt_position = "top",
            width = 0.95,
          },
          flex = { flip_columns = 120 },
        },
        sorting_strategy = "ascending",
      },
      pickers = {
        find_files = {
          mappings = {
            i = {
              ["<A-r>"] = fb_actions.rename,
            },
            n = {
              ["r"] = fb_actions.rename,
            },
          },
        },
        buffers = {
          mappings = {
            i = {
              ["<A-d>"] = require("telescope.actions").delete_buffer,
            },
            n = {
              ["dd"] = require("telescope.actions").delete_buffer,
            },
          },
        },
        git_stash = {
          mappings = {
            i = {
              ["<A-d>"] = git_drop_stash,
            },
            n = {
              ["dd"] = git_drop_stash,
            },
          },
        },
        git_branch = {
          mappings = {
            n = {
              ["<A-a>"] = require("telescope.actions").git_create_branch,
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
              ["r"] = function(prompt_bufnr)
                fb_actions.rename(prompt_bufnr)

                local entry = require("telescope.actions.state").get_selected_entry()
                local old_file = vim.fn.fnamemodify(entry.path, ":t")
                vim.cmd("silent grep! " .. old_file .. " **")
              end,
            },
            i = {
              ["<Alt-a>"] = fb_actions.create_from_prompt,
            },
          },
        },
      },
    })

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("file_browser")
    -- require("telescope").load_extension("ui-select")
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
    -- Wiki articles
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
              require("telescope.actions").close(prompt_bufnr)

              local notes_dir = vim.fn.expand("~/Dropbox/wiki")
              local entry_path = require("telescope.actions.state").get_selected_entry()[1] -- relative to notes_dir
              local entry_name = vim.fn.fnamemodify(entry_path, ":t:r")
              local current_file_path = vim.fn.expand("%:p:h") -- absolute path
              -- get relative path from current_file_path to entry_path
              local relative_filename = vim.fn.trim(
                  vim.fn.system("realpath --relative-to=" .. current_file_path .. " " .. notes_dir .. "/" .. entry_path)
                )
              -- Insert filename in current cursor position
              local link = "[" .. entry_name .. "](" .. relative_filename .. ")"
              vim.api.nvim_put({ link }, "c", true, true)
            end)
            return true
          end,
        })
      end,
    },
    -- Blog posts
    {
      "<leader>fB",
      function()
        require("telescope").extensions.file_browser.file_browser({
          prompt_title = "Blog",
          cwd = "~/code/mactep.github.io/_posts",
        })
      end,
    },
    -- File browser
    {
      "<C-n>",
      function()
        require("telescope").extensions.file_browser.file_browser()
      end,
    },
    -- File browser relative to current file
    {
      "<A-n>",
      function()
        require("telescope").extensions.file_browser.file_browser({
          prompt_title = "Explore current file directory",
          path = "%:p:h",
          select_buffer = true,
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
    -- grep all TODOs in the current project
    {
      "<leader>ft",
      function()
        require("telescope.builtin").grep_string({
          search = "TODO:",
          prompt_title = "Grep TODOs",
          cwd = vim.fn.expand("%:p:h"),
          search_dirs = { vim.fn.expand("%:p:h") },
          only_sort_text = true,
          sorter = require("telescope.sorters").get_fuzzy_file(),
        })
      end,
      { noremap = true, desc = "Grep TODOs" },
    },
  },
}
