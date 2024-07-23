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
        -- create a helperfunction to check if an environment exits:
        local function virtual_environment_exists()
            local path = vim.fn.getcwd()
            local environments = {"env", ".env", "venv", ".venv"}
            -- loop through the directories in the path
            for name in vim.loop.fs_scandir(path) do
                local stat = vim.loop.fs_stat(path .. "/" .. name)
                if stat and stat.type == "directory" then
                    -- check if the directory is a virtual environment
                    for _, env in ipairs(environments) do
                        if name == env then
                            return path .. "/" .. name
                        end
                    end
                end
                return nil
            end

        -- create some function for special terminals
        local Terminal = require("toggleterm.terminal").Terminal
        local anaconda = Terminal:new({ cmd = "~/anaconda3/Scripts/activate.bat;~/anaconda3/python.exe", hidden = true })
        function _ANACONDA_TOGGLE()
            anaconda:toggle()
            map_terminal_hotkeys(anaconda)
        end

        local python = Terminal:new({ cmd = "python3", hidden = true })
        function _PYTHON_TOGGLE()
            python:toggle()
            map_terminal_hotkeys(python)
        end

        local file = nil
        local run_python = nil
        function _RUN_PYTHON_TOGGLE()
            local filename = vim.fn.expand('%')
            -- stop if the file is not a python file
            if not filename:match("%.py$") then
                return
            end
            -- if the file does not match the running file, create a new run_python terminal and
            -- map the hotkeys. Kill the running terminal first if it exists
            if filename ~= file then
                file = filename
                if run_python ~= nil then
                    run_python:shutdown()
                end
                if virtual_environment_exists() then
                    local cmd = "source " .. virtual_environment_exists() .. "/bin/activate;python.exe '" .. file .. "'"
                    run_python = Terminal:new({ cmd = cmd, direction = 'vertical', hidden = true })
                else
                    local cmd = "~\\anaconda3\\Scripts\\activate.bat;~\\anaconda3\\python.exe '" .. file .. "'"
                    run_python = Terminal:new({ cmd = cmd, direction = 'vertical', hidden = true })
                end
                map_terminal_hotkeys(run_python)
            end
            -- if a run python terminal exists
            if run_python ~= nil then
                run_python:toggle()
            end
        end

        vim.keymap.set("n", '<leader>xp', _RUN_PYTHON_TOGGLE,
            { noremap = true, desc = 'Execute python file in split terminal.' })
    end,
}
