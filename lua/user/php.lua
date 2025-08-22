local lspconfig = require("lspconfig")

-- Настройка intelephense
lspconfig.intelephense.setup({
  settings = {
    intelephense = {
      files = {
        maxSize = 5000000;
      },
      environment = {
        includePaths = {"/path/to/your/php/includes"}
      }
    }
  }
})
