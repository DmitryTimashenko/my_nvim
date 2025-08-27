return {
  "marko-cerovac/material.nvim",
  config = function()
    require("material").setup({
      contrast = {
        -- по желанию, например:
        sidebars = true,
        floating_windows = true,
        cursor_line = true,
      },
      styles = {
        comments = { italic = true },
        strings = { bold = true },
      },
      plugins = {
        "gitsigns",
        "nvim-cmp",
        "telescope",
        "which-key",
        -- добавляй нужные тебе
      },
      -- Можно указать вариант темы:
      -- default, darker, lighter, oceanic, palenight, deeper
      theme = "palenight",
    })

    vim.g.material_style = "palenight"
    vim.cmd.colorscheme("material")
  end,
}
