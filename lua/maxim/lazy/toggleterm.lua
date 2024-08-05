-- create a helperfunction to check if an environment exits:
local function virtual_environment_exists()
    local path = vim.fn.getcwd()
    local environments = { "env", ".env", "venv", ".venv" }
    local directories = vim.fn.globpath(path, "*", 0, 1)

    -- loop through the directories in the path
    for _, dir in ipairs(directories) do
        local name = vim.fn.fnamemodify(dir, ":t")
        -- check if the directory is a virtual environment
        for _, env in ipairs(environments) do
            if name == env and vim.fn.isdirectory(dir) then
                return name
            end
        end
    end
    return nil
end

return {
    "akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup({
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.333
                elseif term.direction == "float" then
                    return 25
                end
            end,
            open_mapping = [[<c-\>]],
            on_open = function(term)
                local env = virtual_environment_exists()
                if env then
                    term:send(string.format(".\\%s\\Scripts\\activate", env))
                end
            end,
            terminal_mappings = true,
            hide_numbers = true,
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            close_on_exit = true,
            direction = "float",
            float_opts = {
                border = "curved",
                winblend = 0,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
            },
        })
        -- create a function to map hotkeys to a terminal buffer
        local function map_terminal_hotkeys(e)
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]],
                { buffer = e.buf, noremap = true, desc = "Exit terminal mode." })
            vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-W>h]],
                { buffer = e.buf, noremap = true, desc = "Naviate to left split." })
            vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-W>j]],
                { buffer = e.buf, noremap = true, desc = "Navigate to down split." })
            vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-W>k]],
                { buffer = e.buf, noremap = true, desc = "Navigate to up split." })
            vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-W>l]],
                { buffer = e.buf, noremap = true, desc = "Navigate to right split." })
        end
        -- create some autocommands to set keymappings within the terminal window
        vim.api.nvim_create_augroup("ToggleTerm", { clear = true })
        local autocmd = vim.api.nvim_create_autocmd
        autocmd("TermOpen", {
            group = "ToggleTerm",
            callback = function(e)
                map_terminal_hotkeys(e)
            end
        })
    end,
}
