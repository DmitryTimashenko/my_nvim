local lspconfig = require("lspconfig")

lspconfig.phpactor.setup({
  cmd = { "phpactor", "language-server" },  -- команда запуска phpactor LSP
  filetypes = { "php" },
  root_dir = lspconfig.util.root_pattern("composer.json", ".git"),
  settings = {
    -- phpactor специфичные настройки, если нужны
  },
})
