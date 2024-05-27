return {
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-web-devicons" },
    config = function()
        local navic = require('nvim-navic')
        local colors = require('catppuccin.palettes').get_palette()
        local mytheme = require('lualine.themes.dracula')
        mytheme.terminal = {
            a = { bg = colors.cyan, fg = colors.black, gui = 'bold' },
            b = { bg = colors.lightgray, fg = colors.white },
            c = { bg = colors.gray, fg = colors.white },
        }
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = mytheme,
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
                lualine_c = { "diff", "diagnostics" },
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
                lualine_b = { "filename" },
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
                lualine_y = {},
                lualine_z = { "filetype" },
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = { "filename" },
                lualine_c = {},
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
