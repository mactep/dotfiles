-- git show opens the current file froma given branch in a vertical split window
local git_show = function()
  local branch = vim.fn.input("Branch: ")
  local file = vim.fn.expand("%")
  local command = "git show " .. branch .. ":" .. file
  vim.cmd("vsplit")
  vim.cmd("term " .. command)
end

vim.api.nvim_create_user_command(
  "GitShow",
  git_show,
  { nargs = "?", }
)
