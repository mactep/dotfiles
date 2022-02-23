local present, null_ls = pcall(require, "null-ls")
if not present then
	return
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end


local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local CODE_ACTION = methods.internal.CODE_ACTION

local narutinho = h.make_builtin({
    name = "python import name",
    method = CODE_ACTION,
    filetypes = { "python" },
    generator = {
        fn = function(params)
            local ok, cmp = pcall(require, "cmp")
            if not ok then
                return
            end

            local word = params.content[1]

            local actions = {}
            -- for _, name in ipairs(cmp) do
            table.insert(actions, {
                title = "import "..word,
                action = function()
                    vim.cmd('startinsert!')
                    cmp.complete()
                    cmp.select_next_item()
                    cmp.confirm()
                end,
            })
            return actions
        end,
    },
})

require("null-ls").setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		narutinho,
	},
})
