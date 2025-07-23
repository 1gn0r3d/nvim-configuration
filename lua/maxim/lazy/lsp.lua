return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",
        "onsails/lspkind.nvim",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        -- Next modules enable suggestions and autocompletion
        -- -in buffer
        "hrsh7th/cmp-buffer",
        -- -of file paths
        "hrsh7th/cmp-path",
        -- -- -on commandline
        -- "hrsh7th/cmp-cmdline",

        -- try out blink for extended capabilities.
        "saghen/blink.cmp"

    },
    -- event = "VeryLazy",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        -- Fidget shows a status message of LSP progress in the bottom right
        require("fidget").setup({})

        -- This section sets up default settings to enable completion, etc
        local cmp_lsp = require("cmp_nvim_lsp")
        -- local capabilities = vim.tbl_deep_extend(
        --     "force",
        --     {},
        --     -- Default support (go to definition, completion, hover)
        --     vim.lsp.protocol.make_client_capabilities(),
        --     -- Snippet support, insert/replace, etc
        --     cmp_lsp.default_capabilities())
        local capabilities = require("blink.cmp").get_lsp_capabilities()


        -- Set up navic to get information of the lsp in lualine
        local navic = require("nvim-navic")

        -- This is to set up the lsp configurations in the handlers
        local lspconfig = require("lspconfig")

        require("mason").setup()
        require("mason-lspconfig").setup({
            -- automatic_enable = true,
            automatic_enable = false,
            -- automatic_enable = {
            --     "pylsp",
            -- },
            ensure_installed = {
                "lua_ls",
                "pylsp"
            },
        })

        -- Ignore:
        -- Warnings: binary operator before or after line break
        local ignore_python_warnings = {
            "E402", --Error lines of code before imports
            "W503", --Line break before binary operator
            -- "W504",--Line break after binary operator
        }

        -- Python
        -- Python env settings:
        lspconfig.pylsp.setup({
            on_attach = function(client, bufnr)
                if client.server_capabilities.documentSymbolProvider then
                    navic.attach(client, bufnr)
                end
            end,
            capabilities = capabilities,
            settings = {
                python = {
                    pythonPath = vim.fn.exepath("python3")
                },
                pylsp = {
                    plugins = {
                        pycodestyle = {
                            maxLineLength = 100,
                            ignore = ignore_python_warnings,
                        },
                        black = {
                            enabled = true,
                            line_length = 100,
                            ignore = ignore_python_warnings,
                        },
                    }
                }
            },
            before_init = function(_, config)
                local venv_path = os.getenv("VIRTUAL_ENV")
                -- vim.notify(vim.inspect(venv_path))
                config.settings.python.pythonPath = venv_path
            end
        })

        -- Lua
        lspconfig.lua_ls.setup({
            on_attach = function(client, bufnr)
                if client.server_capabilities.documentSymbolProvider then
                    navic.attach(client, bufnr)
                end
            end,
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = {
                        -- globals = { "vim" } ,
                        globals = { "vim", "it", "describe", "before_each", "after_each" },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = { enable = false },
                },
            },
        })

        -- This part sets up the hover window formatting:
        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover,
            {
                border = "rounded", -- adds a border around the window
                max_width = 80,
                max_height = 20,
            })

        -- get colors from theme
        local colors = require("maxim.lualine_theme.colors")
        -- local float_bg_color = colors.base
        local float_bg_color = colors.surface0
        -- set up colors for general floating windows (harpoon, telescope)
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = float_bg_color, })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = float_bg_color, })
        -- set up colors of completion menu
        vim.api.nvim_set_hl(0, "Pmenu", { bg = float_bg_color, })
        vim.api.nvim_set_hl(0, "PmenuSel", {
            bg = colors.mauve,
            fg = colors.crust,
        })

        -- Loads the lua snippets from luasnip.
        require("luasnip.loaders.from_lua").load({ paths = "./lua/maxim/snippets" })
    end,
}
