-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")


require("plugins.mason")   -- подключает плагины и mason
require("config.lsp")      -- настраивает LSP

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




-- Установка настроек для lazygit.nvim
vim.g.lazygit_use_custom_config_file_path = 1  -- Включить использование кастомного пути к конфигу
vim.g.lazygit_config_file_path = "~/.config/lazygit/config.yml"  -- Указать путь к вашему конфигу Lazygit

-- Или, если вы хотите задать настройки напрямую через переменные Neovim (если плагин это поддерживает)
-- Это менее распространенный способ, но некоторые плагины позволяют так делать
vim.g.lazygit_config = {
    git = {
        skipHookPrefix = "WIP",
    },
}
