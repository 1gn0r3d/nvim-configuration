return {
    'mkajsjo/windowcolumns.nvim',
    version = 'v1.0.0',
    keys = {
        { 'wv',        function() require('windowcolumns').create_column() end },
        { '<leader>s', function() require('windowcolumns').create_column() end },
        -- { 'wh', function() require('windowcolumns').move_column('left') end },
        -- { 'wl', function() require('windowcolumns').move_column('right') end },
        { 'wj',        function() require('windowcolumns').move_window('down') end },
        { 'wk',        function() require('windowcolumns').move_window('up') end },
        { 'wh',        function() require('windowcolumns').move_window('left') end },
        { 'wl',        function() require('windowcolumns').move_window('right') end },
    },
}
