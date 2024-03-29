return {
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
  },
  {
    "vimwiki/vimwiki",
    branch = "dev",
    keys = {
      "<leader>ww",
      "<leader>wi",
      "<leader>w<leader>w",
    },
    event = "BufRead " .. vim.fn.expand("~/Dropbox/wiki/") .. "**",
    init = function()
      vim.g.vimwiki_global_ext = 0
      vim.g.vimwiki_list = {
        {
          path = "~/Dropbox/wiki/",
          syntax = "markdown",
          ext = ".md",
          custom_wiki2html = "~/Dropbox/wiki/wiki2html.sh",
          path_html = "~/Dropbox/wiki_html/",
          template_path = "~/Dropbox/wiki/templates/",
        },
      }
      vim.g.vimwiki_key_mappings = { table_mappings = 0 }
      vim.g.taskwiki_dont_fold = 1
    end,
    config = function()
      vim.cmd([[
          augroup vimwikigroup
              autocmd!
              autocmd BufRead,BufNewFile diary.md VimwikiDiaryGenerateLinks
              autocmd BufNewFile ~/Dropbox/wiki/diary/*.md
                  \ call append(0,[
                  \ "# " . strftime("%d/%m/%Y"), "",
                  \ "## Todo",  "",
                  \ "## Notes", "",
                  \ "## Alternative", "",
                  \ "### Done", "",
                  \ ])
              autocmd BufRead ~/Dropbox/wiki/diary/*.md
                          \ iab <buffer><expr> dt strftime("%c") |
                          \ iab <buffer><expr> ds "start: " . strftime("%c") |
                          \ iab <buffer><expr> df "finish: " . strftime("%c") |
          augroup end
      ]])
    end,
  },
  -- {
  --   "nvim-neorg/neorg",
  --   build = ":Neorg sync-parsers",
  --   cmd = "Neorg",
  --   opts = {
  --     load = {
  --       ["core.defaults"] = {}, -- Loads default behaviour
  --       ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
  --       ["core.norg.dirman"] = { -- Manages Neorg workspaces
  --         config = {
  --           workspaces = {
  --             notes = "~/Dropbox/neorg", -- TODO: merge with Vimwiki
  --           },
  --         },
  --       },
  --     },
  --   },
  --   dependencies = { { "nvim-lua/plenary.nvim" } },
  -- }
  -- {
  --   "serenevoid/kiwi.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", },
  --   config = function()
  --     require("kiwi").setup({
  --       {
  --         name = "work",
  --         path = "/home/mactep/Documents/work-wiki"
  --       },
  --       {
  --         name = "personal",
  --         path = "/home/mactep/Documents/personal-wiki"
  --       }
  --     })
  --   end,
  --   keys = {
  --     {
  --       "<leader>ww",
  --       function() require("kiwi").open_wiki_index() end,
  --     },
  --     {
  --       "<leader>wd",
  --       function() require("kiwi").open_diary_index() end,
  --     },
  --     {
  --       "<leader>wn",
  --       function() require("kiwi").open_diary_new() end,
  --     }
  --   },
  -- },
}
