return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local uv = vim.loop
      local uid = uv.getuid()
      local util = require("lspconfig.util")  -- вот здесь!

      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.php = { "docker_php_cs_fixer" }

      opts.formatters = opts.formatters or {}
      opts.formatters.docker_php_cs_fixer = {
        command = "docker",
        args = function(params)
          local filename = vim.api.nvim_buf_get_name(0)

          if filename == "" then
            vim.notify("Ошибка: файл не сохранен")
            return {}
          end

          local absolute_path = vim.fn.fnamemodify(filename, ":p")
          local root_dir = util.root_pattern("composer.json", ".git")(absolute_path)

          if not root_dir then
            vim.notify("Не удалось определить корень проекта")
            return {}
          end

          local container_path = absolute_path:gsub(vim.pesc(root_dir), "/var/www")

          return {
            "exec",
            "-t",
            "domain-service_php",
            "php",
            "/var/www/vendor/bin/php-cs-fixer",
            "fix",
            "--using-cache=no",
            "--quiet",
            "--allow-risky=yes",
            container_path,
          }
        end,
        cwd = function()
          local bufname = vim.api.nvim_buf_get_name(0)
          local root_dir = util.root_pattern("composer.json", ".git")(bufname)
          return root_dir or vim.fn.getcwd()
        end,
        stdin = false,
      }
    end,
  },
}
