local present, telescope = pcall(require, "telescope")
if present then

    -- makes telescope don"t show preview of big files
    local previewers = require("telescope.previewers")
    local new_maker = function(filepath, bufnr, opts)
        opts = opts or {}

        filepath = vim.fn.expand(filepath)
        vim.loop.fs_stat(filepath, function(_, stat)
            if not stat then return end
            if stat.size > 100000 then
                return
            else
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
            end
        end)
    end

    local fb_actions = telescope.extensions.file_browser.actions
    telescope.setup{
        defaults = {
            sorting_strategy = "ascending",
            layout_config={
                horizontal = {prompt_position="top"},
                vertical = {mirror = true},
            },
            layout_strategy = "vertical",
            buffer_previewer_maker = new_maker,
        },
        pickers = {
            live_grep = {
                debounce = 100,
            },
            buffers = {
                mappings = {
                    i = { ["<c-d>"] = "delete_buffer" },
                    n = { ["<c-d>"] = "delete_buffer" }
                }
            }
        },
        extensions = {
            file_browser = {
                initial_mode = "normal",
                mappings = {
                    n = {
                        ["l"] = "select_default",
                        ["h"] = fb_actions.goto_parent_dir,
                        ["H"] = fb_actions.toggle_hidden,
                        ["<Tab>"] = "toggle_selection"
                    }
                }
            },
        }
    }

    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")

    search_dotfiles = function()
        require("telescope.builtin").find_files({
            prompt_title = "NeoVimRC",
            cwd = vim.fn.stdpath("config")
        })
    end

    browse_blog = function()
        telescope.extensions.file_browser.file_browser({
            prompt_title = "Blog",
            cwd = "~/code/mactep.github.io/_posts",
        })
    end

    find_wiki = function()
        require("telescope.builtin").find_files({
            prompt_title = "Find Wiki",
            cwd = "~/Dropbox/wiki",
            attach_mappings = function(prompt_bufnr, map)
                map("i", "<CR>", function(prompt_bufnr)
                    -- filename is available at entry[1]
                    local entry = require("telescope.actions.state").get_selected_entry()
                    require("telescope.actions").close(prompt_bufnr)
                    local filename = entry[1]
                    -- Insert filename in current cursor position
                    vim.cmd('normal i['..filename..']('..filename..')')
                end)

                return true
            end,
        })
    end

    vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", {noremap=true})
    vim.api.nvim_set_keymap("n", "<leader>fr", "<cmd>Telescope live_grep<cr>", {noremap=true})
    vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", {noremap=true})
    vim.api.nvim_set_keymap("n", "<C-n>", "<cmd>Telescope file_browser<cr>", {noremap=true})
    vim.api.nvim_set_keymap("n", "<leader>fB", "<cmd>Telescope buffers<cr>", {noremap=true})
    vim.api.nvim_set_keymap("n", "<leader>fv", "<cmd>lua search_dotfiles()<cr>", {noremap=true})
    vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua browse_blog()<cr>", {noremap=true})
    vim.api.nvim_set_keymap("n", "<leader>fw", "<cmd>lua find_wiki()<cr>", {noremap=true})
end
