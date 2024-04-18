return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    init = function()
      vim.cmd([[
        function OpenMarkdownPreview (url)
          call jobstart("surf " . a:url)
        endfunction
        let g:mkdp_browserfunc = 'OpenMarkdownPreview'
      ]])
    end,
  },
  {
    dir = "~/code/zk.nvim",
    name = "zk",
    cmd = "Zk",
    keys = {
      "<leader>zf",
      "<leader>zg",
      "<leader>zb",
      "<leader>zd",
      "<leader>zi",
    },
    opts = {
      -- os.getenv("ZK_PATH")
      path = "~/Dropbox/notes",
      diary_path = "~/Dropbox/notes/diary",
    },
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },
}
