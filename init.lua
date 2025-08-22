-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("user.php")

-- Если установили через cargo
vim.g.stylua_path = "/usr/local/bin/stylua"

-- Показывать пробелы как точки
vim.opt.list = true          -- Включить отображение невидимых символов
vim.opt.listchars = {
  space = "·",               -- Пробелы как "·" (можно заменить на ".")
  tab = "→ ",                -- Табы как "→ "
  trail = "•",               -- Пробелы в конце строки как "•"
  nbsp = "␣",                -- Неразрывные пробелы как "␣"
}

vim.g.conform_debug = true


-- Автоматически перезагружать измененные файлы без подтверждения
vim.o.autoread = true
vim.api.nvim_create_autocmd({"FocusGained", "BufEnter", "CursorHold", "CursorHoldI"}, {
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif",
})

-- Отключить диалоговые окна при изменении файла
vim.api.nvim_create_autocmd("FileChangedShell", {
  pattern = "*",
  callback = function()
    vim.v.fcs_choice = "reload"
    vim.cmd("echohl WarningMsg")
    vim.cmd("echo 'File changed externally. Reloading...'")
    vim.cmd("echohl None")
  end,
})

-- Принудительная перезагрузка при сохранении
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.php",
  callback = function()
    vim.cmd("checktime")
  end,
})
