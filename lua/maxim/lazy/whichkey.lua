return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
        notify = false,
    },
    config = function()
        require('which-key').add({
        -- require('which-key').register({
            { "<leader>g",  group = "Git related operations [Gitmoji, NeoGit, Git fugitive]" },
            { "<leader>gt", group = "Toggle ..." },
            { "<leader>h",  group = "Remove search highlights." },
            { "<leader>c",  group = "Cellular automation" },
            { "<leader>cm", group = "MAKE IT RAIN!" },
            { "<leader>cg", group = "Game of life" },
            { "<leader>p",  group = "Project ..." },
            { "<leader>pW", group = "Word ..." },
            { "<leader>pw", group = "Word (with brackets) ..." },
            { "<leader>t",  group = "Trouble ..." },
            { "<leader>v",  group = "LSP" },
            { "<leader>vc", group = "Code actions." },
            { "<leader>vr", group = "References & rename" },
            { "<leader>vw", group = "Search workspace symbols" },
            { "<leader>z",  group = "Zen mode" },
        })
    end
}
