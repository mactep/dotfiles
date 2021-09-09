local file = io.open(os.getenv('HOME')..'/.local/bin/fzf', 'r')

if file == nil then
    os.execute([[
    curl -s https://api.github.com/repos/junegunn/fzf/releases/latest \
    | grep "fzf-.*-linux_amd64.tar.gz" | cut -d : -f 2,3 | tr -d \" \
    | wget -q -i - -O - | tar xvz -C ~/.local/bin/
    ]])
else
    io.close(file)
end

local present, snap = pcall(require, 'snap')
if not present then
    return
end

local file = snap.config.file:with {
    reverse = true,
    prompt = "file",
    suffix = ">>",
    consumer = "fzf",
    preview_min_width = 0,
    producer = "ripgrep.file"
}

local vimgrep = snap.config.vimgrep:with {
    reverse = true,
    prompt = "grep",
    suffix = ">>",
    consumer = "fzf",
    limit = 50000,
    preview_min_width = 0
}

snap.maps {
  {"<Leader>ff", file {}},
  {"<Leader>fr", vimgrep {}},
}
