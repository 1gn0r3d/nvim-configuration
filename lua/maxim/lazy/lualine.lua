local function file_modified()
    if vim.bo.modified then
        return "󰚰 Unsaved changes"
    else
        return ""
    end
end

local function file_or_foldername()
    local oil = require('oil')
    if vim.bo.filetype == 'oil' then
        return oil.get_current_dir()
    else
        return vim.fn.expand("%:t")
    end
end

local function show_maco_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return 'rec 󰑊 macro @' .. recording_register
    end
end

local function git_blame_or_macro_recording()
    local macro_recording = show_maco_recording()
    local git_blame_line = vim.b.gitsigns_blame_line
    if macro_recording ~= "" then
        return macro_recording
    elseif git_blame_line ~= nil then
        return vim.b.gitsigns_blame_line
    else
        return ""
    end
end

return {
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-web-devicons" },
    config = function()
        local navic = require('nvim-navic')
        local oil = require('oil')
        local mytheme = require('maxim.lualine_theme.theme')
        local colors = require('maxim.lualine_theme.colors')

        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = mytheme,
                -- component_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                always_divide_middle = false,
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "diagnostics" },
                lualine_c = { "branch", "diff", git_blame_or_macro_recording },
                lualine_x = { "searchcount" },
                lualine_y = { "location" },
                lualine_z = { "progress" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {
                lualine_a = {},
                lualine_b = { file_or_foldername },
                lualine_c = {
                    {
                        function()
                            return navic.get_location()
                        end,
                        cond = function()
                            return navic.is_available()
                        end,
                        color = { fg = colors['green'] },
                    },
                },
                lualine_x = {},
                lualine_y = { file_modified },
                lualine_z = { "filetype" },
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = { "filename" },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { "filetype" },
            },
            extensions = {},
        })
        -- Disable the command line when not in command mode (to make room for the status bar)
        local function set_cmdheight(height)
            vim.opt.cmdheight = height
        end
        set_cmdheight(0)

        -- create an autocommand group to handle height
        vim.api.nvim_create_augroup("CmdHeightAdjust", { clear = true })
        local autocmd = vim.api.nvim_create_autocmd
        -- autocommands to adjust cmdheight when entering and leaving command mode
        autocmd("CmdLineEnter", {
            group = "CmdHeightAdjust",
            callback = function()
                set_cmdheight(1)
            end,
        })
        autocmd("CmdLineLeave", {
            group = "CmdHeightAdjust",
            callback = function()
                set_cmdheight(0)
            end,
        })

        -- create an autocommand group to refresh the lualine
        vim.api.nvim_create_augroup("LualineRefresh", { clear = true })
        autocmd("RecordingEnter", {
            group = "LualineRefresh",
            callback = function()
                require('lualine').refresh({
                    place = { "statusline" }
                })
            end,
        })
        autocmd("RecordingLeave", {
            group = "LualineRefresh",
            callback = function()
                -- Refreshing is done after 50ms because the register does not instantly clear
                -- after the recording ends.
                local timer = vim.loop.new_timer()
                timer:start(
                    50,
                    0,
                    vim.schedule_wrap(function()
                        require('lualine').refresh({
                            place = { "statusline" }
                        })
                        timer:close()
                    end)
                )
            end,
        })
    end
}
