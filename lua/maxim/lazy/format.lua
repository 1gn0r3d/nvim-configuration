-- return {}
return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                python = { "black", "prettier", stop_after_first = true },
                ["markdown.mdxv"] = { "prettier" },
                lua = { "stylua" },
                go = { "goimports", "gofmt" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            },
        })

        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        vim.keymap.set("n", "<leader>f", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            })
        end, { desc = "Format code layout." })
    end,
}
