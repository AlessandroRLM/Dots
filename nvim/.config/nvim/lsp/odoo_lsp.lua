-- odoo-lsp (https://github.com/Desdaemon/odoo-lsp): Odoo-aware language server.
-- Runs alongside pyright/ruff and adds ORM awareness: model/field completion,
-- _inherit resolution, and go-to-definition across models and XML ids.
-- Enabled in lua/plugins/odoo-lsp.lua; module roots live in the repo's .odoo_lsp.json.
return {
  cmd = { vim.fn.expand("~/.local/bin/odoo-lsp") },
  filetypes = { "python", "xml", "javascript" },
  root_markers = { ".odoo_lsp", ".odoo_lsp.json", ".git" },
}
