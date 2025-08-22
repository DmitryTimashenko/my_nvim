return {
    "yetone/avante.nvim",
    lazy = true,
    version = false,
    event = "VeryLazy",
    opts = {
        provider = "ollama",
        auto_suggestions_provider = "ollama",

        providers = {
            ollama = {
                api_key_name = '',
                __inherited_from = 'openai',
                model = 'qwen3:8b',
                endpoint = "http://127.0.0.1:11434/v1",
                tools = false,
            },
        },

        suggestion = {
            next = "<M-]>",
            prev = "<M-[>",
            accept = "<M-h>",
            dismiss = "<C-]>",
        },
    },
    build = "make",
    dependencies = {
        "hrsh7th/nvim-cmp",
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim",
        "zbirenbaum/copilot.lua",
        "nvim-tree/nvim-web-devicons",
        {
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
        {
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                default = {
                    use_absolute_path = true,
                    prompt_for_file_name = false,
                    embed_image_as_base64 = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                },
            },
        },
    },
}
