return {
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-web-devicons" },
    config = function()
        local navic = require('nvim-navic')
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = "dracula",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                always_divide_middle = true,
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = { "diff" },
                lualine_x = {},
                lualine_y = { "searchcount" },
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
                lualine_b = {},
                lualine_c = {
                    { "filename" },
                    {
                        function()
                            return navic.get_location()
                        end,
                        cond = function()
                            return navic.is_available()
                        end,
                        color = { fg = "#f3ca28" },
                    },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = { "filetype" },
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
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
    end
}
