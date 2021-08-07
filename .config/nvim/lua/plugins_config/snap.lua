package.path = package.path .. ";/home/tulio/.luarocks/share/lua/5.1/?.lua"

local snap = require'snap'

local file = snap.config.file:with {
    reverse = true,
    suffix = ">>",
    prompt = "files",
    consumer = "fzy"
}

local vimgrep = snap.config.vimgrep:with {
    reverse = true,
    suffix = ">>",
    prompt = "grep",
    consumer = "fzy",
    limit = 50000
}


-- Git file producer with ripgrep fallback
file {try = {"git.file", "ripgrep.file"}}

snap.maps {
  {"<Leader>ff", file {producer = "ripgrep.file"}},
  {"<Leader>fg", file {producer = "git.file"}},
  {"<Leader>fr", vimgrep {}},
  {"<Leader>fb", snap.config.file {producer = "vim.buffer"}},
  {"<Leader>fo", snap.config.file {producer = "vim.oldfile"}},
}
