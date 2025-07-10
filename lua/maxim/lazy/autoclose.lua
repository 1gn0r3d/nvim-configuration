return {
    "m4xshen/autoclose.nvim",
    config = function()
        require("autoclose").setup({
            options = {
                -- When inserting a bracket close to other characters, don't auto close
                disable_when_touch = true,
                -- Pair spaces when typing inside of surrounding keys (matches spaces on both sides)
                pair_spaces = true,
            }
        })
    end,
}
