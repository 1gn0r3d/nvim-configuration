return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {},
    config = function()
        require('which-key').register({
            ["<leader>g"] = { name = "Gitmoji & Git fugitive" },
            ["<leader>h"] = { name = "Remove search highlights." },
            ["<leader>m"] = { name = "~~ MAKE IT RAIN! ~~" },
            ["<leader>p"] = { name = "Project ..." },
            ["<leader>pW"] = { name = "Word ..." },
            ["<leader>pw"] = { name = "Word (with brackets) ..." },
            ["<leader>t"] = { name = "Trouble ..." },
            ["<leader>v"] = { name = "LSP" },
            ["<leader>vc"] = { name = "Code actions." },
            ["<leader>vr"] = { name = "References & rename" },
            ["<leader>vw"] = { name = "Search workspace symbols" },
            ["<leader>z"] = { name = "Zen mode" },
        })
    end
}
