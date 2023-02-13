local action_state = require("telescope.actions.state")
local action_set = require("telescope.actions.set")
local actions = require("telescope.actions")

local new_note = function(note_name)
  if note_name == "" then
    return
  end

  local file_name = vim.fn.resolve(os.getenv("ZK_PATH") .. "/" .. os.date("%Y%m%d%H%M") .. "_" .. note_name .. ".md")
  vim.cmd("e " .. file_name)
  vim.cmd("normal ggO# " .. note_name:gsub("_", " "))
  vim.cmd("normal o")
  vim.cmd("normal G")
end

vim.cmd([[command! -nargs=* Zk lua new_note(<f-args>)]])

local note_name_from_args = function(...)
  if select("#", ...) == 0 then
    return
  end

  local words = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(words, v)
  end
  return table.concat(words, "_")
end

local get_node_name_from_prompt = function()
  local note_name = action_state.get_current_line()
  if note_name == "" then
    return
  end
  return note_name:gsub(" ", "_")
end

local present, _ = pcall(require, "telescope")
if not present then
  return
end

local attach_mappings = function(prompt_bufnr, map)
  local create_new_note = function()
    local note_name = get_node_name_from_prompt()
    actions.close(prompt_bufnr)
    new_note(note_name)
  end

  map("i", "<C-e>", create_new_note)
  map("n", "<C-e>", create_new_note)
  return true
end

local search_zk = function()
  require("telescope.builtin").find_files({
    prompt_title = "Notes",
    cwd = "$ZK_PATH",
    attach_mappings = attach_mappings,
  })
end

local grep_zk = function()
  require("telescope.builtin").live_grep({
    prompt_title = "grep notes",
    cwd = "$ZK_PATH",
  })
end

local browse_zk = function()
  require("telescope").extensions.file_browser.file_browser({
    prompt_title = "Notes",
    cwd = "$ZK_PATH",
    attach_mappings = attach_mappings,
  })
end

local find_link = function()
  require("telescope.builtin").find_files({
    prompt_title = "Find Wiki",
    cwd = "$ZK_PATH",
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        -- filename is available at entry[1]
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        local filename = entry[1]
        -- Insert filename in current cursor position
        vim.cmd("normal i[" .. filename .. "](" .. filename .. ")")
      end)

      return true
    end,
  })
end

vim.keymap.set("n", "<leader>zf", search_zk, { noremap = true })
vim.keymap.set("n", "<leader>zg", grep_zk, { noremap = true })
vim.keymap.set("n", "<leader>zb", browse_zk, { noremap = true })
vim.keymap.set("n", "<leader>zl", find_link, { noremap = true })
vim.keymap.set("i", "<C-l>", find_link, { noremap = true })
