local file = io.open(os.getenv("HOME").."/.local/bin/fzf", "r")

if file == nil then
    os.execute([[
    curl -s https://api.github.com/repos/junegunn/fzf/releases/latest \
    | grep "fzf-.*-linux_amd64.tar.gz" | cut -d : -f 2,3 | tr -d \" \
    | wget -q -i - -O - | tar xvz -C ~/.local/bin/
    ]])
else
    io.close(file)
end

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
            file_browser = {
                dir_icon = "|"
            },
            live_grep = {
                debounce = 100,
            },
            buffers = {
                mappings = {
                    i = { ["<c-d>"] = "delete_buffer" },
                    n = { ["<c-d>"] = "delete_buffer" }
                }
            }
        }
    }

    telescope.load_extension("fzf")

    search_dotfiles = function()
        require("telescope.builtin").find_files({
            prompt_title = "NeoVimRC",
            cwd = vim.fn.stdpath("config")
        })
    end

    browse_blog = function()
        require("telescope.builtin").file_browser({
            prompt_title = "Blog",
            cwd = "~/code/mactep.github.io/_posts",
        })
    end

    browse_zk = function()
        require("telescope.builtin").file_browser({
            prompt_title = "Notes",
            cwd = "~/Documents/notes",
            -- this bunch of crap is here because I want to create a file with
            -- a datetime prefix and a '.md' suffix
            -- TODO: try to get the actual function and run a set_current_line before
            attach_mappings = function(prompt_bufnr, map)
              local action_state = require('telescope.actions.state')
              local Path = require('plenary.path')
              local os_sep = Path.path.sep
              local is_dir = function(value)
                return value:sub(-1, -1) == os_sep
              end

              local create_new_file = function()
                local current_picker = action_state.get_current_picker(prompt_bufnr)
                local file = action_state.get_current_line()
                if file == "" then return end

                file = os.date("%Y%m%d%H%M") .. '_' .. file .. '.md'
                local fpath = current_picker.cwd .. os_sep .. file
                if not is_dir(fpath) then
                  require('telescope.actions').close(prompt_bufnr)
                  Path:new(fpath):touch { parents = true }
                  vim.cmd(string.format(":e %s", fpath))
                else
                  Path:new(fpath:sub(1, -2)):mkdir { parents = true }
                  local new_cwd = vim.fn.expand(fpath)
                  current_picker.cwd = new_cwd
                  current_picker:refresh(opts.new_finder(new_cwd), { reset_prompt = true })
                end
              end

              map("i", "<C-e>", create_new_file)
              map("n", "<C-e>", create_new_file)
              return true
            end,
        })
    end

    map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", {noremap=true})
    map("n", "<leader>fr", "<cmd>Telescope live_grep<cr>", {noremap=true})
    map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", {noremap=true})
    map("n", "<leader>fB", "<cmd>Telescope buffers<cr>", {noremap=true})
    map("n", "<C-n>",      "<cmd>Telescope file_browser<cr>", {noremap=true})
    map("n", "<leader>fv", "<cmd>lua search_dotfiles()<cr>", {noremap=true})
    map("n", "<leader>fb", "<cmd>lua browse_blog()<cr>", {noremap=true})
    map("n", "<leader>fz", "<cmd>lua browse_zk()<cr>", {noremap=true})
end
