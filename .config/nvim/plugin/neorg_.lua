local present, neorg = pcall(require, 'neorg')
if present then
    neorg.setup({
        load = {
            ["core.defaults"] = {}, -- Load all the default modules
            ["core.norg.concealer"] = {}, -- Allows for use of icons
            ["core.norg.dirman"] = { -- Manage your directories with Neorg
                config = {
                    workspaces = {
                        my_workspace = "~/Dropbox/wiki"
                    }
                }
            },
            ["core.keybinds"] = { -- Configure core.keybinds
                config = {
                    default_keybinds = true, -- Generate the default keybinds
                    neorg_leader = "<Leader>o" -- This is the default if unspecified
                }
            },
            ["core.integrations.telescope"] = {}, -- Enable the telescope module
        },
    })

    local present, parsers = pcall(require, 'nvim-treesitter.parsers')
    if present then
        local parser_configs = parsers.get_parser_configs()

        parser_configs.norg = {
            install_info = {
                url = "https://github.com/nvim-neorg/tree-sitter-norg",
                files = { "src/parser.c", "src/scanner.cc" },
                branch = "main"
            },
        }
    end
end
