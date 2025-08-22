return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      filters = {
        dotfiles = false, -- ПОКАЗЫВАТЬ скрытые файлы
        custom = {},
      },
      git = {
        ignore = true, -- показывать файлы из .gitignore
      },
    },
  },
}
