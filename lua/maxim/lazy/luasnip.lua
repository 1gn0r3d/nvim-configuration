return {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    lazy = false,
    config = function()
        -- require("luasnip.loaders.from_lua").load({ paths = "./lua/maxim/snippets" })
        -- vim.notify("Snippets loaded from luasnip configuration.", vim.log.levels.INFO)
        local ls = require("luasnip")

        ls.setup({
            history = true,
            updateevents = { "TextChanged", "TextChangedI" },
            -- enable_autosnippets = true,
        })

        -- Set keymaps for luasnip
        -- Keymap to jump or expand forward (if possible)
        vim.keymap.set({ "i", "s" }, "<C-e>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end, { silent = true })

        -- Keymap to jump backwards (if possible)
        vim.keymap.set({ "i", "s" }, "<C-b>", function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, { silent = true })
    end,
}
