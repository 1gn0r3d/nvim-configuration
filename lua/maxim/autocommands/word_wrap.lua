local group = vim.api.nvim_create_augroup('word_wrap', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
    group = group,
    callback = function()
        if (vim.bo.filetype == "md") or (vim.bo.filetype == "tex") then
            vim.cmd("setlocal wrap")
        end
    end
})
