return {
  {
    "nvim-treesitter/nvim-treesitter",
    ft = {
      "bash",
      "c",
      "css",
      "go",
      "graphql",
      "html",
      "http",
      "javascript",
      "json",
      "latex",
      "lua",
      "proto",
      "python",
      "rust",
      "typescript",
      "vimdoc",
    },
    opts = {
      -- A list of parser names, or "all" (the four listed parsers should always be installed)
      ensure_installed = {
        "bash",
        "c",
        "comment",
        "css",
        "go",
        "graphql",
        "html",
        "http",
        "javascript",
        "json",
        "latex",
        "lua",
        "proto",
        "python",
        "rust",
        "typescript",
        "vimdoc",
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          -- init_selection = "gnn",
          -- node_incremental = "grn",
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobjects, similar to targets.vim
          lookahead = true,

          keymaps = {
            ["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
            ["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
            ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          },
          -- You can choose the select mode (default is charwise 'v')
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V",  -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          include_surrounding_whitespace = true,
        },

        lsp_interop = {
          enable = true,
          border = "none",
          floating_preview_opts = {},
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer",
          },
        },
      },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
    },
    build = ":TSUpdate",
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-treesitter/playground",
    cmd = {
      "TSPlaygroundToggle",
      "TSHighlightCapturesUnderCursor",
      "TSCaptureUnderCursor",
    },
    keys = {
      { "<F2>", "<cmd>TSHighlightCapturesUnderCursor<cr>", desc = "Show highlight group under cursor" },
    },
    dependencies = { "nvim-treesitter" },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    ft = {
      "bash",
      "c",
      "css",
      "go",
      "graphql",
      "html",
      "http",
      "javascript",
      "json",
      "latex",
      "lua",
      "proto",
      "python",
      "rust",
      "typescript",
      "vimdoc",
    },
    dependencies = { "nvim-treesitter" },
  }
}
