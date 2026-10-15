return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    { "nvim-telescope/telescope.nvim", version = "*", dependencies = { "ibhagwan/fzf-lua" } },
  },
  ft = "python",
  keys = { { ",v", "<cmd>VenvSelect<cr>" } },
  opts = {
    options = {
      log_level = "TRACE",
    },
    search = {
      miniforge_envs = {
        command = "fd 'bin/python$' ~/miniforge3/envs --no-ignore-vcs --full-path --color never",
        type = "anaconda",
      },
    },
  },
}
