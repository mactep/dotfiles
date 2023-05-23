-- original by tLaw101:
-- https://www.reddit.com/r/neovim/comments/ua6826/3_lua_override_vimuiinput_in_40_lines/
local function wininput(opts, on_confirm)
  -- create a "prompt" buffer that will be deleted once focus is lost
  local buf = vim.api.nvim_create_buf(false, false)
  vim.bo[buf].buftype = "prompt"
  vim.bo[buf].bufhidden = "wipe"

  local prompt = opts.prompt or ""
  local default_text = opts.default or ""

  -- set prompt and callback (CR) for prompt buffer
  vim.fn.prompt_setprompt(buf, '') -- no prompt as we are using title
  vim.fn.prompt_setcallback(buf, on_confirm)

  -- set some keymaps: CR confirm and exit, ESC in normal mode to abort
  vim.keymap.set({ "i", "n" }, "<CR>", "<CR><Esc>:close!<CR>:stopinsert<CR>", {
    silent = true,
    buffer = buf,
  })
  vim.keymap.set("n", "<esc>", function()
    return vim.fn.mode() == "n" and "ZQ" or "<esc>"
  end, { expr = true, silent = true, buffer = buf })

  local win_opts = {
    title = prompt,
    title_pos = 'left',
    width = 50,
    height = 1,
    relative = "cursor",
    row = 1,
    col = 0,
    border = "rounded",
    style = "minimal",
  }

  -- adjust window width so that there is always space for prompt plus a little bit
  win_opts.width = #default_text + 5 < win_opts.width
    and win_opts.width
    or #default_text + 5

  -- open the floating window pointing to our buffer and show the prompt
  vim.api.nvim_open_win(buf, true, win_opts)
  vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, { default_text })
end

-- override vim.ui.input ( telescope rename/create, lsp rename, etc )
vim.ui.input = wininput
