---Copies a text to the system clipboard.
---@param text string
local copy_to_clipboard = function(text)
  vim.fn.setreg("+", text)
  vim.cmd('echo "Copied to clipboard: ' .. text .. '"')
end

---Executes a shell command and returns the trimmed output.
---@param cmd string
---@return string
local system_call = function(cmd)
  local output = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    return ""
  end

  if output == nil then
    return ""
  end

  output = output:gsub("\n", "")

  return output
end

---Returns the relative path of the current file to the git root.
---@return string?
local relative_path = function()
  local file_path = vim.fn.expand("%:p") --[[@as string]]

  -- file likely doesn't exist
  if file_path == "" then
    return nil
  end

  local repo_path = system_call("git rev-parse --show-toplevel")
  if repo_path == "" then
    return nil
  end

  -- if file_path is not inside repo_path, then it's not in a git repository
  local is_inside_repo = file_path:find(repo_path, 1, true)
  if not is_inside_repo then
    return nil
  end

  local relative_path = file_path:sub(#repo_path + 1)

  return relative_path
end

---Returns the HTTPS URL of the remote origin repository.
-- If it's an SSH URL, it will be converted to HTTPS.
---@return string?
local get_repo_url = function()
  local remote = system_call("git config --get remote.origin.url")
  if remote == "" then
    return nil
  end

  if remote:find("git@") then
    remote = remote:gsub(":", "/")
    remote = remote:gsub("git@", "https://")
    remote = remote:gsub("%.git", "")
  end

  return remote
end

---Returns the selected file lines info in Github URL format
---#L<line> or #L<start_line>-L<end_line>
---@param command_info table
---@return string
local line_info = function(command_info)
  -- if range is 0, then the command was called without a range, don't add line info
  -- if range is 1, I don't know what that means, but don't add line info
  if command_info.range == 0 or command_info.range == 1 then
    return ""
  end

  local start_line = command_info.line1
  local end_line = command_info.line2

  if start_line == end_line then
    return "#L" .. start_line
  end

  return "#L" .. start_line .. "-L" .. end_line
end

---Returns the current git branch name or nil if not in a git repository.
---@return string?
local get_current_git_branch_name = function()
  local branch = system_call("git rev-parse --abbrev-ref HEAD")
  if branch == "" then
    return nil
  end

  return branch
end

---Returns the default branch name or nil if not in a git repository.
---@return string?
local get_default_branch_name = function()
  local default_branch = system_call("git config --get init.defaultBranch")
  if default_branch == "" then
    return nil
  end

  return default_branch
end

---@class GitRemote
local M = {}

---Copies and print the URL of the current file in the remote repository to
---the system clipboard.
---@param command_info table
M.file_url = function(command_info)
  local path = relative_path()
  if path == nil then
    return print("Not in a git repository!")
  end
  local lines = line_info(command_info)
  local branch = system_call("git rev-parse --abbrev-ref HEAD")
  if branch == "" then
    return print("Not in a git repository!")
  end
  local remote = get_repo_url()

  local url = remote .. "/blob/" .. branch .. path .. lines

  copy_to_clipboard(url)
end

---Copies and print the URL to the page that compares the current branch with
---the default remote branch.
M.open_pr_url = function()
  local repo = get_repo_url()
  local branch = get_current_git_branch_name()
  if branch == nil then
    return print("Not in a git repository!")
  end

  local default_branch = get_default_branch_name()
  if default_branch == nil then
    return print("Not in a git repository!")
  end
  local url = repo .. "/compare/" .. default_branch .. "..." .. branch .. "?expand=1"

  copy_to_clipboard(url)
end

vim.api.nvim_create_user_command(
  "RemoteFileURL",
  M.file_url,
  { range = true }
)
vim.api.nvim_create_user_command(
  "OpenPRURL",
  M.open_pr_url,
  {}
)

return M
