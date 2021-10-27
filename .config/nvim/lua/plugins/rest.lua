local present, rest = pcall(require, 'rest-nvim')
if present then
    local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
    parser_configs.http = {
        install_info = {
            url = 'https://github.com/NTBBloodbath/tree-sitter-http',
            files = { 'src/parser.c' },
            branch = 'main',
        },
    }
    rest.setup({
        result_split_horizontal = false,
    })
end
