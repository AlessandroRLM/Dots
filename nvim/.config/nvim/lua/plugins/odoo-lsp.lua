-- Enable odoo-lsp alongside pyright/ruff. The server definition (cmd, filetypes,
-- root markers) lives in ~/.config/nvim/lsp/odoo_lsp.lua; this just turns it on.
return {
  {
    -- Plugin: nvim-lspconfig
    -- URL: https://github.com/neovim/nvim-lspconfig
    -- Description: LSP client configuration; LazyVim enables servers listed here.
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        odoo_lsp = {},
      },
    },
  },
}
