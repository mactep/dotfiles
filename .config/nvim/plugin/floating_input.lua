-- original by tLaw101:
-- https://www.reddit.com/r/neovim/comments/ua6826/3_lua_override_vimuiinput_in_40_lines/

local settings = {
  max_width = 100,
  width_padding = 20,
}

local default_opts = {
  prompt = "",
  default = "",
}

local default_win_opts = {
  relative = "editor",

  row = vim.o.lines / 2 - 1,
  col = vim.o.columns / 2 - 25,
  height = 1,
  width = 0,

  focusable = true,
  style = "minimal",
  border = "rounded",
  title = "",

  -- used to prevent telescope from closing when the prompt is opened
  noautocmd = true,
}

-- set some keymaps: CR confirm and exit, ESC in normal mode to abort
local function set_keymaps(buf)
  vim.keymap.set({ "i", "n" }, "<CR>", "<CR><Esc>:close!<CR>:stopinsert<CR>", {
    silent = true,
    buffer = buf,
  })
  vim.keymap.set("n", "<esc>", function()
    return vim.fn.mode() == "n" and "ZQ" or "<esc>"
  end, { expr = true, silent = true, buffer = buf })

  vim.keymap.set("n", "q", function()
    return vim.fn.mode() == "n" and "ZQ" or "<esc>"
  end, { expr = true, silent = true, buffer = buf })
end

-- defer the on_confirm callback so that it is executed after the prompt window is closed
local function defer_callback(on_confirm)
  return function(input)
    vim.defer_fn(function()
      on_confirm(input)
    end, 10)
  end
end

-- create a "prompt" buffer that will be deleted once focus is lost
local function create_prompt_buffer(on_confirm)
  local buf = vim.api.nvim_create_buf(false, false)
  vim.bo[buf].buftype = "prompt"
  vim.bo[buf].bufhidden = "wipe"

  -- defer the on_confirm callback so that it is
  -- executed after the prompt window is closed
  local deferred_callback = defer_callback(on_confirm)

  -- set prompt and callback (CR) for prompt buffer
  vim.fn.prompt_setprompt(buf, "")
  vim.fn.prompt_setcallback(buf, deferred_callback)

  set_keymaps(buf)

  return buf
end

-- set the default text
local function set_contents(buf, prompt_opts)
  vim.api.nvim_buf_set_text(
    buf,
    0,
    0,
    0,
    0,
    { prompt_opts.default }
  )
end

-- start insert mode if there is default text
local function startinsert(prompt_opts)
  -- exit insert mode in a case by case basis
  if false then
    vim.cmd("stopinsert")                    -- by default, we are in insert mode
    -- vim.api.nvim_win_set_cursor(0, { 1, #prompt_opts.prompt + 1 })
    vim.api.nvim_win_set_cursor(0, { 1, 0 }) -- move the cursor to the start of the line
  end
end

local function get_width(prompt_opts)
  local total_width = math.max(#prompt_opts.default, #prompt_opts.prompt) + settings.width_padding
  if total_width > settings.max_width then
    return settings.max_width
  end

  return total_width
end

local function get_title(prompt_opts)
  -- if prompt_opts.prompt ends with a colon or colon-space, remove it
  local prompt = prompt_opts.prompt:gsub(":%s*$", "")

  return prompt
end

local function floating_input(prompt_opts, on_confirm, win_opts)
  prompt_opts = vim.tbl_deep_extend("force", default_opts, prompt_opts)

  win_opts = vim.tbl_deep_extend("force", default_win_opts, win_opts)
  win_opts.width = get_width(prompt_opts)
  win_opts.title = get_title(prompt_opts)

  local buf = create_prompt_buffer(on_confirm)

  -- open the floating window pointing to our buffer and show the prompt
  vim.api.nvim_open_win(buf, true, win_opts)

  -- actions on the buffer needs to be deferred after the prompt is drawn
  vim.defer_fn(function()
    set_contents(buf, prompt_opts)

    startinsert(prompt_opts)
  end, 5)
end

-- override vim.ui.input
vim.ui.input = function(opts, on_confirm)
  -- intercept opts and on_confirm,
  -- check buffer options, filetype, etc and set window options accordingly.
  floating_input(
    opts,
    on_confirm,
    { relative = "cursor", row = 1, col = 0 }
  )
end
