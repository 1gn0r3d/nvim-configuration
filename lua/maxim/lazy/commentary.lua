return {
    "tpope/vim-commentary",
    config = function()
        vim.keymap.set("n", "<leader>/", ":Commentary<CR>",
            { noremap = true, silent = true, desc = "Comment out line." })
        vim.keymap.set("v", "<leader>/", [[:Commentary<CR>`<gv]],
            { noremap = true, silent = true, desc = "Comment out a visual selection." })
    end,
}
