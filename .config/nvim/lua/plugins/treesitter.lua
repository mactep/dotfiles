local file_types = {
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
  "markdown",
  "proto",
  "python",
  "query",
  "rust",
  "typescript",
  "vimdoc",
  "yaml",
}

local parsers = vim.tbl_extend("force", file_types, {
  "markdown_inline",
})

return {
  {
    "nvim-treesitter/nvim-treesitter",
    ft = file_types,
    cmd = {
      "TSPlaygroundToggle",
    },
    opts = {
      -- A list of parser names, or "all" (the four listed parsers should always be installed)
      ensure_installed = parsers,

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      indent = {
        enable = true,
        disable = { "python" }, -- there are some issues going on https://github.com/nvim-treesitter/nvim-treesitter/issues/1136
      },

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
            ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop region" },
            ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop region" },
            ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional region" },
            ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional region" },
            ["aB"] = { query = "@block.outer", desc = "Select outer part of a block region" },
            ["iB"] = { query = "@block.inner", desc = "Select inner part of a block region" },
            ["aC"] = { query = "@comment.outer", desc = "Select outer part of a comment region" },
            ["iC"] = { query = "@comment.inner", desc = "Select inner part of a comment region" },
            ["a,"] = { query = "@parameter.outer", desc = "Select inner part of a parameter region" },
            ["i,"] = { query = "@parameter.inner", desc = "Select inner part of a parameter region" },
          },
          -- You can choose the select mode (default is charwise 'v')
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.inner"] = "V",  -- linewise
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
    },
    build = ":TSUpdate",
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- use Treesitter to fold
      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.o.foldtext = ""
      vim.o.fillchars = "fold: "
      vim.o.foldlevel = 2
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    ft = file_types,
    dependencies = { "nvim-treesitter" },
  }
}
