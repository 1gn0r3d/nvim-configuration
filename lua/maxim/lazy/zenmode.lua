return {
    "folke/zen-mode.nvim",
    config = function()
        vim.keymap.set("n", "<leader>zz", function()
            require("zen-mode").setup {
                window = {
                    width = 120,
                    options = {}
                },
            }
            vim.wo.wrap = false
            vim.wo.number = true
            vim.wo.rnu = true
            vim.opt.colorcolumn = "100"
            require("zen-mode").toggle()
        end, { desc = "Toggle zen mode." })


        vim.keymap.set("n", "<leader>zZ", function()
            require("zen-mode").setup {
                window = {
                    width = 110,
                    options = {}
                },
            }
            require("zen-mode").toggle()
            vim.wo.wrap = false
            vim.wo.number = false
            vim.wo.rnu = false
            vim.opt.colorcolumn = "0"
        end, { desc = "Toggle zen mode. (no line markers)" })
    end
}
