---@class opts
---@field name string
---@field repo string
---@field executable string
---@field strip_components boolean

--- Download a release from github and extract it to a directory
---@param opts opts
local download_release = function(opts)
  local servers_path = vim.fn.stdpath("data") .. "/language_servers"
  local server_path = servers_path .. "/" .. opts.name
  local executable = server_path .. opts.executable

  if vim.fn.filereadable(executable) ~= 0 then
    return
  end

  print("Downloading " .. opts.name .. "...")

  local out = vim.system({ "mkdir", "-p", server_path }):wait()
  if out.code ~= 0 then
    print("Failed to create directory: " .. server_path)
    print(out.stdout)
    return
  end

  local releases = vim.system({
    "curl",
    "-s",
    "https://api.github.com/repos/" .. opts.repo .. "/releases/latest",
  }):wait()
  if releases.code ~= 0 then
    print("Failed to get latest " .. opts.name .. " release")
    print(releases.stderr)
    return
  end

  local download_url = ""
  local decoded_releases = vim.fn.json_decode(releases.stdout)
  for _, asset in ipairs(decoded_releases.assets) do
    if string.find(asset.name, "linux") and not string.find(asset.name, "musl") and (string.find(asset.name, "amd") or string.find(asset.name, "x64")) then
      download_url = asset.browser_download_url
      break
    end
  end
  print("Downloading " .. download_url)

  local tarbal = vim.system({
    "curl",
    "-sL",
    download_url,
  }):wait()
  if out.code ~= 0 then
    print("Failed to download " .. opts.name)
    print(out.stderr)
    return
  end

  local tar_cmd = { "tar", "xz", "-C", server_path }

  if opts.strip_components then
    table.insert(tar_cmd, "--strip-components=1")
  end

  out = vim.system(
    tar_cmd,
    { stdin = tarbal.stdout }
  ):wait()
  if out.code ~= 0 then
    print("Failed to extract " .. opts.name)
    print(out.stderr)
    return
  end

  vim.system({ "chmod", "u+x", executable }):wait()
  if out.code ~= 0 then
    print("Failed to make " .. opts.name .. " executable")
    return
  end

  print("Done!")
end

local efm = function()
  if vim.fn.executable("efm-langserver") ~= 0 then
    return
  end

  local efm_path = vim.fn.stdpath("data") .. "/language_servers/efm/"
  local executable = efm_path .. "/efm-langserver"
  if vim.fn.filereadable(executable) == 0 then
    download_release({
      name = "efm",
      repo = "mattn/efm-langserver",
      executable = "efm-langserver",
      strip_components = true,
    })
  end

  if not string.find(vim.env.PATH, efm_path, 1, true) then
    vim.env.PATH = efm_path .. ":" .. vim.env.PATH
  end
end

local gopls = function()
  if vim.fn.executable("gopls") ~= 0 then
    return
  end

  local servers_path = vim.fn.stdpath("data") .. "/language_servers"
  local gopls_path = servers_path .. "/gopls"
  local gopls = gopls_path .. "/bin/gopls"

  if vim.fn.filereadable(gopls) == 0 then
    print("Downloading gopls...")

    local previous_gobin = vim.env.GOBIN
    vim.env.GOBIN = gopls_path .. "/bin"

    local out = vim.system({ "mkdir", "-p", gopls_path .. "/bin" }):wait()
    if out.code ~= 0 then
      print("Failed to create directory " .. gopls_path .. "/bin")
      return
    end

    out = vim.system({ "go", "install", "golang.org/x/tools/gopls@latest" }):wait()
    if out.code ~= 0 then
      print("Failed to install gopls")
      return
    end

    vim.env.GOBIN = previous_gobin

    print("Done!")
  end

  -- if bin path not in path, add it
  local bin_path = servers_path .. "/gopls/bin"
  if not string.find(vim.env.PATH, bin_path, 1, true) then
    vim.env.PATH = bin_path .. ":" .. vim.env.PATH
  end
end

local luals = function()
  if vim.fn.executable("lua-language-server") ~= 0 then
    return
  end

  local servers_path = vim.fn.stdpath("data") .. "/language_servers"
  local luals_path = servers_path .. "/luals"
  local luals = luals_path .. "/bin/lua-language-server"

  if vim.fn.filereadable(luals) == 0 then
    download_release({
      name = "luals",
      repo = "LuaLS/lua-language-server",
      executable = "bin/lua-language-server",
      strip_components = false,
    })
  end

  -- if bin path not in path, add it
  local bin_path = luals_path .. "/bin"
  if not string.find(vim.env.PATH, bin_path, 1, true) then
    vim.env.PATH = bin_path .. ":" .. vim.env.PATH
  end
end

local bufls = function()
  if vim.fn.executable("bufls") ~= 0 then
    return
  end

  local servers_path = vim.fn.stdpath("data") .. "/language_servers"
  local bufls_path = servers_path .. "/bufls"
  local bufls = bufls_path .. "/bin/bufls"

  if vim.fn.filereadable(bufls) == 0 then
    print("Downloading bufls...")

    local previous_gobin = vim.env.GOBIN
    vim.env.GOBIN = bufls_path .. "/bin"

    local out = vim.system({ "mkdir", "-p", bufls_path .. "/bin" }):wait()
    if out.code ~= 0 then
      print("Failed to create directory " .. bufls_path .. "/bin")
      return
    end

    out = vim.system({ "go", "install", "github.com/bufbuild/buf-language-server/cmd/bufls@latest" }):wait()
    if out.code ~= 0 then
      print("Failed to install bufls")
      return
    end

    vim.env.GOBIN = previous_gobin

    print("Done!")
  end

  -- if bin path not in path, add it
  local bin_path = servers_path .. "/bufls/bin"
  if not vim.env.PATH:find(bin_path, 1, true) then
    vim.env.PATH = bin_path .. ":" .. vim.env.PATH
  end
end

local tsserver = function()
  if vim.fn.executable("typescript-language-server") ~= 0 then
    return
  end

  local servers_path = vim.fn.stdpath("data") .. "/language_servers"
  local tsserver_path = servers_path .. "/tsserver"
  local tsserver = tsserver_path .. "/node_modules/.bin/typescript-language-server"

  if vim.fn.filereadable(tsserver) == 0 then
    print("Downloading tsserver...")

    local out = vim.system({ "mkdir", "-p", tsserver_path }):wait()
    if out.code ~= 0 then
      print("Failed to create directory " .. tsserver_path)
      return
    end

    out = vim.system({ "npm", "install", "typescript-language-server@latest" }, { cwd = tsserver_path }):wait()
    if out.code ~= 0 then
      print("Failed to install tsserver")
      return
    end

    print("Done!")
  end

  -- if bin path not in path, add it
  local bin_path = tsserver_path .. "/node_modules/.bin"
  if not vim.env.PATH:find(bin_path, 1, true) then
    vim.env.PATH = bin_path .. ":" .. vim.env.PATH
  end
end

return function()
  efm()
  gopls()
  luals()
  bufls()
  tsserver()
end
