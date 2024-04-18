-- generate a uuid
vim.keymap.set("ia", "uu", 'system("uuidgen")[:-2]', { expr = true })
local uuid_must_parse = function()
  local uuid = vim.fn.system("uuidgen")
  uuid = vim.fn.substitute(uuid, "\n", "", "g")

  return 'uuid.MustParse("' .. uuid .. '")'
end
vim.keymap.set("ia", "UU", uuid_must_parse, { expr = true })

-- date and time
vim.keymap.set("ia", "dt", 'strftime("%Y-%m-%d")', { expr = true })
vim.keymap.set("ia", "tm", 'strftime("%H:%M:%S")', { expr = true })

-- typos
vim.cmd.iabbrev("zise", "size")
vim.cmd.iabbrev("filezise", "filesize")
