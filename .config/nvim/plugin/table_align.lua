function _G.alignMdTable()
  local pattern = "^%s*|%s.*%s|%s*$"
  local lineNumber = vim.fn.line(".")
  local currentColumn = vim.fn.col(".")
  local previousLine = vim.fn.getline(lineNumber - 1)
  local currentLine = vim.fn.getline(".")
  local nextLine = vim.fn.getline(lineNumber + 1)

  -- if currentLine is an array of strings exit
  if type(currentLine) == "table" or type(previousLine) == "table" or type(nextLine) == "table" then
    return
  end

  local isTableLine = string.match(currentLine, "^%s*|")
  local isPreviousLineTableLine = string.match(previousLine, pattern)
  local isNextLineTableLine = string.match(nextLine, pattern)

  if vim.fn.exists(":Tabularize") and isTableLine and (isPreviousLineTableLine or isNextLineTableLine) then
    print("aligning")
    local column = #currentLine:sub(1, currentColumn):gsub("[^|]", "")
    local position = #vim.fn.matchstr(currentLine:sub(1, currentColumn), ".*|\\s*\\zs.*")
    vim.cmd("Tabularize/|/l1") -- `l` means left aligned and `1` means one space of cell padding
    vim.cmd("normal! 0")
    vim.fn.search(("[^|]*|"):rep(column) .. ("\\s\\{-\\}"):rep(position), "ce", lineNumber)
  end
end

function _G.alignLatexTable()
  local pattern = "^%s*%&%s.*%s%&%s*$"
  local lineNumber = vim.fn.line(".")
  local currentColumn = vim.fn.col(".")
  local previousLine = vim.fn.getline(lineNumber - 1)
  local currentLine = vim.fn.getline(".")
  local nextLine = vim.fn.getline(lineNumber + 1)

  -- if currentLine is an array of strings exit
  if type(currentLine) == "table" or type(previousLine) == "table" or type(nextLine) == "table" then
    return
  end

  local isTableLine = string.match(currentLine, "^%s*%&")
  local isPreviousLineTableLine = string.match(previousLine, pattern)
  local isNextLineTableLine = string.match(nextLine, pattern)

  if vim.fn.exists(":Tabularize") and isTableLine and (isPreviousLineTableLine or isNextLineTableLine) then
    local column = #currentLine:sub(1, currentColumn):gsub("[^%&]", "")
    local position = #vim.fn.matchstr(currentLine:sub(1, currentColumn), ".*%&\\s*\\zs.*")
    vim.cmd("Tabularize/&/l1") -- `l` means left aligned and `1` means one space of cell padding
    vim.cmd("normal! 0")
    vim.fn.search(("[^%&]*%&"):rep(column) .. ("\\s\\{-\\}"):rep(position), "ce", lineNumber)
  end
end

-- Align table when | is pressed in insert mode
vim.keymap.set("i", "<Bar>", "<Bar><Esc>:call v:lua.alignMdTable()<CR>a")

-- Align table when & is pressed in insert mode and is not preceded by \
vim.keymap.set("i", "&", "&<Esc>:call v:lua.alignLatexTable()<CR>a")

vim.api.nvim_create_autocmd("InsertLeave", {
  group = vim.api.nvim_create_augroup("alignMdTable", {}),
  pattern = { "*.md", "*.tex" },
  callback = function(ev)
    -- if the last 3 chars of ev.file are .md
    if string.sub(ev.file, -3) == ".md" then
      alignMdTable()
    elseif string.sub(ev.file, -4) == ".tex" then
      alignLatexTable()
    end
  end
})
