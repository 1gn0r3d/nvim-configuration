-- Function to adjust the widths of the vertical splits
local function adjust_window_width(window)
    -- Get the width from the colorcolumn setting
    local colorcolumn = vim.o.colorcolumn

    if colorcolumn == "" then
        colorcolumn = "80"
    end

    local colorcolumn_list = split(colorcolumn, ",")
    for i, value in ipairs(colorcolumn_list) do
        colorcolumn_list[i] = tonumber(value)
    end

    local colorcolumn_width = math.max(unpack(colorcolumn_list))
    local width = math.floor(colorcolumn_width * 1.05)

    -- Set the width of the bufnr
    vim.api.nvim_win_set_width(window, width)
end

local function open_new_vsplit_and_resize_previous()
    -- Get the buffer number of the active buffer
    local active_buffer = vim.api.nvim_get_current_win()

    -- Open a new vertical split
    vim.cmd("vsplit")

    -- Get the buffer number of the new buffer
    local new_buffer = vim.api.nvim_get_current_win()

    -- Resize the previous buffer
    adjust_window_width(active_buffer)

    -- Set the active buffer to the new buffer
    vim.api.nvim_set_current_win(new_buffer)
end

-- Create a VIM command to test:
vim.api.nvim_create_user_command("VS", function()
    open_new_vsplit_and_resize_previous()
end, {})

-- Create an autocommand on window open:
local augroup = vim.api.nvim_create_augroup("VSplitResizer", { clear = true })
vim.api.nvim_create_autocmd("CmdlineEnter", {
    pattern = '*',
    group = augroup,
    callback = function()
        local cmd = vim.fn.getcmdline()
        if cmd:match('^vsplit') or cmd:match('^vsp') then
            open_new_vsplit_and_resize_previous()
        end
    end
})
