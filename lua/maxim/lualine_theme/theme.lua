local colors = require('maxim.lualine_theme.colors')
return {
    normal = {
        a = { bg = colors.mauve, fg = colors.crust, gui = 'bold' },
        b = { bg = colors.surface1, fg = colors.text },
        c = { bg = colors.surface0, fg = colors.text },
    },
    insert = {
        a = { bg = colors.green, fg = colors.crust, gui = 'bold' },
        b = { bg = colors.surface1, fg = colors.text },
        c = { bg = colors.surface0, fg = colors.text },
    },
    visual = {
        a = { bg = colors.yellow, fg = colors.crust, gui = 'bold' },
        b = { bg = colors.surface1, fg = colors.text },
        c = { bg = colors.surface0, fg = colors.text },
    },
    replace = {
        a = { bg = colors.red, fg = colors.crust, gui = 'bold' },
        b = { bg = colors.surface1, fg = colors.text },
        c = { bg = colors.surface0, fg = colors.text },
    },
    command = {
        a = { bg = colors.peach, fg = colors.crust, gui = 'bold' },
        b = { bg = colors.surface1, fg = colors.text },
        c = { bg = colors.surface0, fg = colors.text },
    },
    inactive = {
        a = { bg = colors.surface2, fg = colors.text, gui = 'bold' },
        b = { bg = colors.surface1, fg = colors.text },
        c = { bg = colors.surface0, fg = colors.text },
    },
    terminal = {
        a = { bg = colors.blue, fg = colors.crust, gui = 'bold' },
        b = { bg = colors.surface1, fg = colors.text },
        c = { bg = colors.surface0, fg = colors.text },
    },
}
