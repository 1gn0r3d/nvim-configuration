-- Autocommand to open help files in a vertical split
local augroup = vim.api.nvim_create_augroup("HelpVerticalSplit", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    -- pattern = '*.txt',
    callback = function()
        if vim.bo.filetype == "help" then
            require('windowcolumns').move_window('right')
        end
    end
})
