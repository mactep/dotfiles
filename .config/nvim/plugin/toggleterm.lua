-- This config maps <space>t to open a terminal in a new tab. When the terminal is closed, the tab is closed.
-- When <space>t is pressed inside the terminal, close the tab, but keep the terminal buffer alive.
-- The implementation uses neovim's terminal.
-- On terminal close, close the tab and clear the terminal_buffer_id

local terminal_buffer_id = nil

local augroup = vim.api.nvim_create_augroup("toggleterm", {})
local terminal_autocmd = function(bufnr)
  vim.api.nvim_create_autocmd("TermClose", {
    pattern = "*",
    group = augroup,
    -- buffer = bufnr, -- for some reason this does not work
    callback = function(ctx)
      if ctx.buf == terminal_buffer_id then
        terminal_buffer_id = nil
      end
    end,
  })
end


local function open_terminal()
  if terminal_buffer_id == nil then
    vim.cmd("tab terminal")
    terminal_buffer_id = vim.api.nvim_get_current_buf()
    terminal_autocmd(terminal_buffer_id)
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd("startinsert")
  else
    vim.cmd("tab sbuffer " .. terminal_buffer_id)
  end
end

local function close_tab()
  -- if there's only one buffer, create a new buffer
  if vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 })) == 1 then
    vim.cmd("enew")
    return
  end

  -- if there's only one tab, switch to the next buffer.
  if vim.fn.tabpagenr("$") == 1 then
    vim.cmd("bnext")
  end

  vim.cmd("tabclose")
end

local function toggle_terminal()
  if vim.api.nvim_get_current_buf() == terminal_buffer_id then
    close_tab()
  else
    open_terminal()
  end
end


vim.keymap.set("n", "<space>t", toggle_terminal, { noremap = true, silent = true })
