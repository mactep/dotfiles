command! -nargs=* Zk call zk#edit(<f-args>)
command! Backlinks execute 'silent grep! -H -r % $ZK_PATH' | copen

func! zk#edit(...)
  " build the file name
  let l:sep = ''
  if len(a:000) > 0
    let l:sep = '_'
  endif
  let l:fname = expand('$ZK_PATH') . strftime('%Y%m%d%H%M') . l:sep . join(a:000, '_') . '.md'

  " edit the new file
  exec "e " . l:fname

  " enter the title and timestamp (using ultisnips) in the new file
  if len(a:000) > 0
    exec "normal ggO# " . join(a:000) . "\<cr>\<esc>G"
  endif
endfunc

lua << EOF
    local present, telescope = pcall(require, "telescope")
    if present then
        search_zk = function()
            require("telescope.builtin").find_files({
                prompt_title = "Notes",
                cwd = "$ZK_PATH",
            })
        end

        grep_zk = function()
            require("telescope.builtin").live_grep({
                prompt_title = "grep notes",
                cwd = "$ZK_PATH",
            })
        end

        browse_zk = function()
            require("telescope.builtin").file_browser({
                prompt_title = "Notes",
                cwd = "$ZK_PATH",
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
                        require('telescope.actions').close(prompt_bufnr)
                        vim.cmd(string.format(":call zk#edit('%s')", file))
                    end

                    map("i", "<C-e>", create_new_file)
                    map("n", "<C-e>", create_new_file)
                    return true
                end,
            })
        end

        find_link = function()
            require("telescope.builtin").find_files({
                prompt_title = "Find Wiki",
                cwd = "$ZK_PATH",
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

        vim.api.nvim_set_keymap("n", "<leader>zf", "<cmd>lua search_zk()<cr>", {noremap=true})
        vim.api.nvim_set_keymap("n", "<leader>zg", "<cmd>lua grep_zk()<cr>", {noremap=true})
        vim.api.nvim_set_keymap("n", "<leader>zb", "<cmd>lua browse_zk()<cr>", {noremap=true})
        vim.api.nvim_set_keymap("n", "<leader>zl", "<cmd>lua find_link()<cr>", {noremap=true})
        vim.api.nvim_set_keymap("i", "<C-l>", "<cmd>lua find_link()<cr>", {noremap=true})
    end
EOF
