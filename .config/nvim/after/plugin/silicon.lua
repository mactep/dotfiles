present, silicon = pcall(require, "silicon")
if not present then
	return
end

silicon.setup({ output = "" })
vim.keymap.set("v", "<Leader>s", function()
	silicon.visualise_api({ to_clip = true })
end)
