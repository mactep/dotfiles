vim.opt_local.spelllang = "pt"
vim.opt_local.spell = true
vim.opt_local.tw = 79
vim.opt_local.cc = "80"

vim.api.nvim_create_autocmd(
  "BufWritePost",
  {
    group = vim.api.nvim_create_augroup("compile_tex", {}),
    pattern = "*.tex",
    callback = function()
      vim.fn.jobstart("tectonic --synctex --keep-logs --keep-intermediates " .. vim.fn.expand("%"), {
        on_exit = function(_, code)
          if code == 0 then
            print("compiled successfully")
          else
            print("failed to compile")
          end
        end,
      })
    end
  })

vim.api.nvim_create_autocmd(
  "BufWinLeave",
  {
    group = vim.api.nvim_create_augroup("clean_tex", {}),
    pattern = "*.tex",
    callback = function()
      vim.fn.system("latexmk -c")
      vim.fn.system("rm " .. vim.fn.expand("%:r") .. ".synctex.gz")
      vim.fn.system("rm " .. vim.fn.expand("%:r") .. ".aux " .. vim.fn.expand("%:r") .. ".log")
    end
  })

local open_zathura = function()
  local position = vim.api.nvim_win_get_cursor(0)
  local line = position[1]
  local col = position[2]
  local file = vim.fn.expand("%:p")
  local pdf = vim.fn.substitute(file, "tex$", "pdf", "")
  local command = "zathura -x 'nvr --remote +" ..
  line .. " " .. file .. "' --synctex-forward " .. line .. ":" .. col .. ":" .. file .. " " .. pdf
  print(command)
  vim.fn.jobstart(command)
end
vim.keymap.set(
  "n",
  "<leader><Enter>",
  open_zathura,
  { noremap = true, silent = true }
)

local tabular_content_query = [[
; query
(generic_environment
  begin: (begin
    name: (curly_group_text
      text: (text) @begin (#eq? @begin "tabular")
      )
    )
  (text) @content
)
]]

-- command to align inner columns of a tabular environment
local align_table_columns = [[ !column -t -s $'&' -o \& ]]

-- align table finds all occurrences of tabular environments and aligns them
-- using the column command
local align_table = function()
  local content = vim.treesitter.get_query("latex", "0.1.0"):query(tabular_content_query)
  local start_line = content[1]:start()
  local end_line = content[1]:end_()
  local range = { start_line[1], start_line[2], end_line[1], end_line[2] }
  vim.api.nvim_command(table.concat({ range[1], range[2], range[3], range[4], align_table_columns }))
end

-- pad_table_rows should split the lines of the selected line range when a
-- `\\ \hline` is found, add whitespaces at the end of each line and append a
-- `\\ \hline` at the end of each line
_G.pad_table_rows = function()
  local lines = vim.api.nvim_buf_get_lines(0, vim.fn.line("'<") - 1, vim.fn.line("'>") - 1, false)
  local padded_lines = {}
  for _, line in ipairs(lines) do
    local padded_line = line
    if string.match(line, "\\\\ \\hline") then
      padded_line = string.gsub(line, "\\\\ \\hline", "\\\\")
      padded_line = padded_line .. string.rep(" ", vim.opt_local.tw:get() - string.len(padded_line) - 2) .. "\\\\ \\hline"
    else
      padded_line = padded_line .. string.rep(" ", vim.opt_local.tw:get() - string.len(padded_line))
    end
    table.insert(padded_lines, padded_line)
  end
  vim.api.nvim_buf_set_lines(0, vim.fn.line("'<") - 1, vim.fn.line("'>") - 1, false, padded_lines)
end
