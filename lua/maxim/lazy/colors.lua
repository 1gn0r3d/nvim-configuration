return {
    {
        -- "folke/tokyonight.nvim", name = "tokyonight",
        -- "rose-pine/nvim", name = "rose-pine",
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            -- vim.cmd([[colorscheme tokyonight-storm]])
            -- vim.cmd([[colorscheme rose-pine]])
            vim.cmd([[colorscheme catppuccin-frappe]])
            -- Set the background colours
            vim.cmd("highlight Normal ctermbg=none guibg=none")
            vim.cmd("highlight NormalFloat ctermbg=none guibg=none")
            vim.cmd("highlight NormalNC ctermbg=none guibg=none")
        end,
    },
}
