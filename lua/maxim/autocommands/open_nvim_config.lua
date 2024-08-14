vim.api.nvim_create_user_command('Config', function()
    local config_path = vim.fn.stdpath('config')
    vim.cmd('cd ' .. config_path)
    vim.cmd('edit ' .. config_path)
    vim.cmd('Oil .')
end, { nargs = 0 }
)
