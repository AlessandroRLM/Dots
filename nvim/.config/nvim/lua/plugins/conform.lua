-- Route Python format-on-save through conform -> ruff, reusing the project's
-- .ruff.toml. The LazyVim python extra registers ruff only as an LSP and leaves
-- conform (LazyVim's primary format-on-save engine) without a python formatter,
-- so formatting silently never runs. This makes it explicit.
return {
  {
    -- Plugin: conform.nvim
    -- URL: https://github.com/stevearc/conform.nvim
    -- Description: Lightweight formatter plugin used by LazyVim for format-on-save.
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_organize_imports", "ruff_format" },
        xml = { "prettier" },
      },
    },
  },
}
