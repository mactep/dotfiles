return {
  settings = {
    texlab = {
      build = {
        executable = "tectonic",
        args = { "%f", "--synctex", "--keep-logs", "--keep-intermediates" },
      },
    },
  },
}