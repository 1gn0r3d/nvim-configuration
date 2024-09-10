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
    -- config = function()
    --     require('which-key').register({
    --         { "<leader>c",  group = "Copilot ..." },
    --         { "<leader>cc", group = "CopilotChat ..." },
    --         { "<leader>g",  group = "Git related operations [Gitmoji, NeoGit, Git fugitive]" },
    --         { "<leader>gt", group = "Toggle ..." },
    --         { "<leader>h",  group = "Remove search highlights." },
    --         { "<leader>m",  group = "~~ MAKE IT RAIN! ~~" },
    --         { "<leader>p",  group = "Project ..." },
    --         { "<leader>pW", group = "Word ..." },
    --         { "<leader>pw", group = "Word (with brackets) ..." },
    --         { "<leader>t",  group = "Trouble ..." },
    --         { "<leader>v",  group = "LSP" },
    --         { "<leader>vc", group = "Code actions." },
    --         { "<leader>vr", group = "References & rename" },
    --         { "<leader>vw", group = "Search workspace symbols" },
    --         { "<leader>z",  group = "Zen mode" },
    --     })
    -- end
}
