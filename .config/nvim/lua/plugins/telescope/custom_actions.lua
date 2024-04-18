local M = {}

-- @param prompt_bufnr number: The prompt bufnr
-- Drops the selected stash
M.git_drop_stash = function(prompt_bufnr)
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

-- Launches find_files in the directory under cursor
M.find_inside_dir_under_cursor = function()
  local action_state = require("telescope.actions.state")

  local entry_path = action_state.get_selected_entry().Path
  local dir = entry_path:is_dir() and entry_path or entry_path:parent()
  local relative = dir:make_relative(vim.fn.getcwd())

  require("telescope.builtin").find_files({
    results_title = relative .. "/",
    cwd = dir:absolute(),
  })
end

-- Launches live_grep in the directory under cursor
M.grep_dir_under_cursor = function()
  local action_state = require("telescope.actions.state")
  -- local live_grep = require("telescope.builtin").live_grep
  -- For live_grep_args
  local live_grep = require("telescope").extensions.live_grep_args.live_grep_args

  local entry_path = action_state.get_selected_entry().Path
  local dir = entry_path:is_dir() and entry_path or entry_path:parent()
  local relative = dir:make_relative(vim.fn.getcwd())

  live_grep({
    results_title = relative .. "/",
    cwd = dir:absolute(),
  })
end

-- Copies the file under the cursor to the current directory.
-- The fb_actions.copy action does not work properly on vanila telescope.
M.find_files_copy = function(prompt_bufnr)
  local fb_utils = require "telescope._extensions.file_browser.utils"
  local action_state = require "telescope.actions.state"
  local Path = require "plenary.path"

  local get_target_dir = function()
    -- a string with the relative path to the current directory and the name of the file
    local target_file = action_state.get_selected_entry()[1]
    -- target_dir is the target_file without the file name
    local target_dir = Path:new(target_file):parent():absolute()

    return target_dir
  end

  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local finder = current_picker.finder
  local parents = Path:new(finder):parents()

  local selections = fb_utils.get_selected_files(prompt_bufnr, true)
  if vim.tbl_isempty(selections) then
    fb_utils.notify("actions.copy", { msg = "No selection to be copied!", level = "WARN", quiet = finder.quiet })
    return
  end

  local target_dir = get_target_dir()

  local copied = {}
  local index = 1
  local copy_selections
  copy_selections = function()
    -- scoping
    local selection, name, destination, exists
    while index <= #selections do
      selection = selections[index]
      local is_dir = selection:is_dir()
      local absolute = selection:absolute()
      name = table.remove(selection:_split())
      destination = Path:new {
        target_dir,
        name,
      }

      -- copying file or folder within original directory
      if destination:exists() then
        exists = true -- trigger vim.ui.input outside loop to avoid interleaving
        break
      else
        if is_dir and absolute == destination:parent():absolute() then
          local message = string.format("Copying folder into itself not (yet) supported", name)
          fb_utils.notify("actions.copy", { msg = message, level = "INFO", quiet = finder.quiet })
        elseif is_dir and vim.tbl_contains(parents, absolute) then
          local message = string.format("Copying a parent folder into path not supported", name)
          fb_utils.notify("actions.copy", { msg = message, level = "INFO", quiet = finder.quiet })
        else
          selection:copy {
            destination = destination,
            recursive = true,
            parents = true,
          }
          table.insert(copied, name)
        end
        index = index + 1
      end
    end

    if exists then
      exists = false
      vim.ui.input({
        prompt = string.format(
          "Please enter a new name, <CR> to overwrite (merge), or <ESC> to skip file (folder):\n",
          name
        ),
        default = destination:absolute(),
        completion = "file",
      }, function(input)
        vim.cmd [[ redraw ]] -- redraw to clear out vim.ui.prompt to avoid hit-enter prompt
        if input ~= nil then
          selection:copy {
            destination = input,
            recursive = true,
            parents = true,
          }
          table.insert(copied, name)
        end
        index = index + 1
        copy_selections()
      end)
    else
      if not vim.tbl_isempty(copied) then
        local message = "Copied: " .. table.concat(copied, ", ")
        fb_utils.notify("actions.copy", { msg = message, level = "INFO", quiet = finder.quiet })
      end
    end
  end
  copy_selections()

  require("telescope.builtin").find_files()
end

return M
