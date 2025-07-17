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
    },
    -- event = "VeryLazy",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        -- Fidget shows a status message of LSP progress in the bottom right
        require("fidget").setup({})

        -- This section sets up default settings to enable completion, etc
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            -- Default support (go to definition, completion, hover)
            vim.lsp.protocol.make_client_capabilities(),
            -- Snippet support, insert/replace, etc
            cmp_lsp.default_capabilities())

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
            }
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
        -- set up colors for general floating windows (harpoon, telescope)
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors['surface0'], })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = colors['surface0'], })
        -- set up colors of completion menu
        vim.api.nvim_set_hl(0, "Pmenu", { bg = colors['surface1'] })
        vim.api.nvim_set_hl(0, "PmenuSel", { bg = colors['surface2'] })

        -- set up colors of documentation popup
        vim.api.nvim_set_hl(0, "CmpDocumentation", { bg = colors['surface1'] })

        -- This part handles autocompletion
        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local lspkind = require("lspkind")
        local luasnip = require("luasnip")
        -- path = "./lua/maxim/snippets"
        -- abs_path = vim.fn.fnamemodify(path, ":p")
        -- vim.notify("Path: " .. abs_path, vim.log.levels.Info)
        require("luasnip.loaders.from_lua").load({ paths = "./lua/maxim/snippets" })
        -- vim.notify("Snippets loaded from lsp configuration.", vim.log.levels.INFO)

        cmp.setup({
            -- This sets up a snippet for autocompletion of a function in lua
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            -- This sets up the hotkeys for navigating and selecting
            -- autocompletion setups
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
            -- This indicates the sources which can be used for autocompletion
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            }),

            -- Set up the formatting, lspkind adds symbols
            formatting = {
                window = {
                    documentation = cmp.config.window.bordered(),

                },
                format = function(entry, vim_item)
                    -- Add symbol & text
                    vim_item.kind = lspkind.symbolic(vim_item.kind, {
                        mode = "symbol_text"
                    })

                    -- Add source name (e.g. [LSP], [Snippet], [Buffer])
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        luasnip = "[Snippet]",
                        nvim_lua = "[Lua]",
                        path = "[Path]",
                        buffer = "[Buffer]",
                    })[entry.source.name] or ("[" .. entry.source.name .. "]")

                    return vim_item
                end
            }
            -- formatting = {
            --     format = lspkind.cmp_format({
            --         mode = 'symbol',
            --         maxwidth = {
            --             menu = 50,
            --             abbr = 50,
            --         },
            --         symbol_map = { Copilot = "" },
            --         elipsis_char = '...',
            --         show_labelDetails = true,
            --     }),
            -- }
        })
    end,
}
