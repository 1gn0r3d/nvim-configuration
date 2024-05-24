local attach_to_buffer = function(output_bufnr, file_pattern, commands)
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("file_execution_magic", { clear = true }),
        pattern = file_pattern,
        callback = function()
            local append_data = function(_, data)
                if data then
                    vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
                end
            end

            vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, {
                "Code output: ",
            })

            for _, command in ipairs(commands) do
                vim.fn.jobstart(command, {
                    stdout_buffered = true,
                    on_stdout = append_data,
                    on_stderr = append_data,
                })
            end
        end
    })
end


vim.api.nvim_create_user_command("Autorun", function()
    local filename = vim.fn.expand('%')
    local pattern = '*.py'
    local current_pane = vim.api.nvim_get_current_win()

    local total_width = vim.o.columns
    vim.api.nvim_command('vsplit new')
    local split_width = math.floor(total_width * .40)
    vim.cmd("wincmd l")
    vim.cmd("vertical resize " .. split_width)

    local output_bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_name(output_bufnr, "Python code output: ")

    attach_to_buffer(output_bufnr, pattern, {
        { "C:\\Users\\MaximeVanrusselt\\anaconda3\\Scripts\\activate.bat" },
        { "C:\\Users\\MaximeVanrusselt\\anaconda3\\python.exe",           filename },
    })
    vim.api.nvim_set_current_win(current_pane)
end, {})
