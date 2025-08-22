return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local uv = vim.loop
      local uid = uv.getuid()

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
          local home_path = vim.fn.expand("~/projects/shared-dictionaries-service")
          local container_path = absolute_path:gsub(
            vim.pesc(home_path),
            "/var/www"
          )

          return {
            "compose",
            "--file=.ops/docker-compose.app.yml",
            "--project-directory=.",
            "exec",
            "-T",
            "-u", tostring(uid),
            "app",
            "/var/www/vendor/bin/php-cs-fixer",
            "fix",
            "--using-cache=no",
            "--quiet",
            "--allow-risky=yes",
            container_path
          }
        end,
        cwd = function()
          return "/home/timashenkod/projects/shared-dictionaries-service"
        end,
        stdin = false,
      }

      -- Автокоманда для принудительной перезагрузки
      vim.api.nvim_create_autocmd("User", {
        pattern = "ConformPostFormat",
        callback = function(args)
          local bufnr = args.data.bufnr
          if vim.api.nvim_buf_is_valid(bufnr) then
            vim.schedule(function()
              local filename = vim.api.nvim_buf_get_name(bufnr)
              if filename ~= "" then
                -- Сохраняем состояние
                local cursor_pos = vim.api.nvim_win_get_cursor(0)
                local modified = vim.api.nvim_buf_get_option(bufnr, 'modified')
                
                -- Принудительно перезагружаем
                vim.cmd("silent! edit!")
                
                -- Восстанавливаем состояние
                vim.api.nvim_win_set_cursor(0, cursor_pos)
                vim.api.nvim_buf_set_option(bufnr, 'modified', modified)
              end
            end)
          end
        end,
      })

      return opts
    end,
  }
}
