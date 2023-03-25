local action_state = require("telescope.actions.state")
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

-- Autocommands
local diary_path = vim.fn.resolve(os.getenv("ZK_PATH") .. "/diary")
local zkgroup = vim.api.nvim_create_augroup("zkcmds", {})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = zkgroup,
  pattern = diary_path .. "diary.md",
  callback = function()
    -- TODO: generate backlinks based on a tag system
  end,
})

local function insert_top_header(title)
  vim.cmd("normal ggO# " .. title)
  vim.cmd("normal o")
end

local function insert_header(subtitle, level)
  level = level or 2
  vim.cmd("normal o" .. string.rep("#", level) .. " " .. subtitle)
  vim.cmd("normal o")
end

vim.api.nvim_create_autocmd({ "BufNewFile" }, {
  group = zkgroup,
  pattern = diary_path .. "/*.md",
  callback = function()
    insert_top_header(os.date("%d/%m/%Y"))
    insert_header("Todo")
    insert_header("Notes")
    insert_header("Alternative")
    insert_header("Done", 3)

    vim.cmd("iab <buffer><expr> dt strftime('%c')")
    vim.cmd("iab <buffer><expr> ds 'start: ' . strftime('%c')")
    vim.cmd("iab <buffer><expr> df 'finish: ' . strftime('%c')")
  end,
})

-- Edit diary entries
local function open_diary_entry(filename)
  -- resolve filename
  local file = vim.fn.resolve(diary_path .. "/" .. filename)
  print(file)
  vim.cmd("e " .. file)
  -- set local working directory to diary_path
  vim.cmd("lcd " .. diary_path)
end

local function edit_todays_diary()
  local todays_diary = vim.fn.resolve(diary_path .. "/" .. os.date("%Y-%m-%d") .. ".md")
  open_diary_entry(todays_diary)
end
vim.keymap.set("n", "<leader>dd", edit_todays_diary, { noremap = true, silent = true })

local function get_current_diary_index()
  local files = vim.fn.glob(diary_path .. "/*.md", true, true)
  local current_file = vim.fn.expand("%:p")
  return vim.fn.index(files, current_file)
end

-- The code will note work as expected if the current entry is not saved on disk
local function edit_next_diary()
  local index = get_current_diary_index()
  if index == -1 then
    -- edit tomorrow's diary
    -- may need to check if this entry is already open to avoid editing the same buffer every time
    open_diary_entry(os.date("%Y-%m-%d", os.time() + 86400) .. ".md")
  else
    local files = vim.fn.glob(diary_path .. "/*.md", true, true)
    if index == #files then
      return
    end
    vim.cmd("e " .. files[index + 1])
  end
end
vim.keymap.set("n", "<leader>dn", edit_next_diary, { noremap = true, silent = true })

-- Same problem as mentioned above
local function edit_prev_diary()
  local index = get_current_diary_index()
  if index == -1 then
    -- edit yesterday's diary
    open_diary_entry(os.date("%Y-%m-%d", os.time() - 86400) .. ".md")
  else
    local files = vim.fn.glob(diary_path .. "/*.md", true, true)
    if index == 1 then
      return
    end
    vim.cmd("e " .. files[index - 1])
  end
end
vim.keymap.set("n", "<leader>dp", edit_prev_diary, { noremap = true, silent = true })

-- Telescope integration
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
