local nilawayCommand =
  "nilaway" ..
  " -pretty-print false -json" ..
  ' -exclude-pkgs="github.com/getalternative/svc-partner-gateway/internal/generated,github.com/getalternative/svc-partner-gateway/tests/mocks"' ..
  ' -include-pkgs="github.com/getalternative/"' ..
  ' -include-errors-in-files="internal/transport-inbound/graphql/resolvers/customerFeeConfig.resolvers.go"' ..
  " ./..." ..
  [[ | sed -e 's/\\n//g' -e 's/\\t//g' -e 's/-\\u003e//g' |]] ..
  [[ jq -r '.[] | .[] | .[].posn' ]]

return {
  cmd = {
    "efm-langserver",
    "-logfile",
    "/home/mactep/.local/state/nvim/efm.log",
    "-loglevel",
    "3",
  },
  init_options = {
    documentFormatting = true,
    hover = true,
    documentSymbol = true,
    codeAction = true,
    completion = true,
  },
  settings = {
    languages = {
      go = {
        {
          lintCommand = "revive -formatter unix -config " .. vim.fn.stdpath("config") .. "/assets/revive.toml",
          lintIgnoreExitCode = true,
          lintStdin = true,
          lintFormats = { "%.%#:%l:%c: %m" },
        },
        -- {
        --   lintCommand = 'nilaway -include-pkgs="github.com/getalternative/" ${INPUT}',
        --   lintSource = "nilaway",
        --   lintIgnoreExitCode = true,
        --   lintSeverity = 1, -- error
        -- },
      },
      yaml = {
        { formatCommand = "prettierd --parser yaml", formatStdin = true }
      },
      markdown = {
        { formatCommand = "prettierd --parser markdown", formatStdin = true }
      },
      json = {
        { formatCommand = "jq ." },
      },
      graphql = {
        { formatCommand = "prettierd --parser graphql", formatStdin = true },
      },
      proto = {
        { formatCommand = "buf format ${INPUT}" },
        {
          lintCommand = "buf lint ${INPUT}",
          lintSeverity = 3,
        },
      },
      sh = {
        {
          formatCommand = "shellharden --transform ${INPUT}",
        }
      },
      nix = {
        { formatCommand = "nixpkgs-fmt", formatStdin = true },
      },
    },
  },
  filetypes = {
    "go",
    "yaml",
    "markdown",
    "json",
    "graphql",
    "proto",
    "sh",
    "nix",
  },
  single_file_support = true,
}
