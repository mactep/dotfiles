-- if editing any file inside ~/.config/nvim/, set the GIT_DIR environment
-- variable to $HOME/.dotfiles and the GIT_WORK_TREE environment variable to
-- $HOME. When the buffer is closed or we change to another buffer, unset the
-- GIT_DIR and GIT_WORK_TREE environment variables.

local augroup = vim.api.nvim_create_augroup("nvim_config_git", {})
local config_path = vim.fn.stdpath("config")

if type(config_path) ~= "string" then
  return
end

local config_glob = config_path .. "/**"

vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup,
  pattern = config_glob,
  callback = function()
    if vim.bo.buftype ~= "" then
      return
    end

    vim.env.GIT_DIR = vim.env.HOME .. "/.dotfiles"
    vim.env.GIT_WORK_TREE = vim.env.HOME
  end,
})

vim.api.nvim_create_autocmd("BufLeave", {
  group = augroup,
  pattern = config_path .. "/**",
  callback = function()
    if vim.env.GIT_DIR ~= nil or vim.env.GIT_WORK_TREE ~= nil then
      vim.env.GIT_DIR = nil
      vim.env.GIT_WORK_TREE = nil
    end
  end,
})
