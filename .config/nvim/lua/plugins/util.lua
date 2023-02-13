return {
  {
    "NTBBloodbath/rest.nvim",
    opts = {
      result_split_horizontal = false,
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "narutoxy/silicon.lua",
    opts = {
      output = "",
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
}
