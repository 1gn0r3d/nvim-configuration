return {
    'saghen/blink.cmp',
    dependencies = {
        -- 'rafamadriz/friendly-snippets',
        { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    },

    version = 'v0.*',

    opts = {
        snippets = { preset = 'luasnip' },
        keymap = { preset = 'default' },

        appearance = {
            use_nvim_cmp_as_default = true,
            -- nerd_font_variant = '',
        },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' }, },

        signature = {
            enabled = true,
            window = { border = 'single' }
        },
        completion = {
            menu = {
                border = 'rounded',
                draw = {
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                local icon = ctx.kind_icon
                                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                    if dev_icon then
                                        icon = dev_icon
                                    end
                                else
                                    icon = require("lspkind").symbolic(ctx.kind, {
                                        mode = "symbol",
                                    })
                                end

                                return icon .. ctx.icon_gap
                            end,

                            -- Optionally, use the highlight groups from nvim-web-devicons
                            -- You can also add the same function for `kind.highlight` if you want to
                            -- keep the highlight groups in sync with the icons.
                            highlight = function(ctx)
                                local hl = ctx.kind_hl
                                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                                    if dev_icon then
                                        hl = dev_hl
                                    end
                                end
                                return hl
                            end,
                        },
                    },
                    columns = {
                        { "kind_icon", "label", "label_description", gap = 1 }, { "kind_icon", "kind", "source_name", gap = 1 }
                    },
                }
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                window = { border = 'rounded' },
            },
        },
    },
}
