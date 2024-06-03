return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require('gitsigns').setup({
            -- Setup highlighting: use rownumbers rather than signcolumn.
            numhl = true,
            signcolumn = false,
            current_line_blame = true,

            -- Setup hotkeys
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation keys
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gitsigns.nav_hunk('next')
                    end
                end)

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end)

                -- toggle between number column highlighting and signcolumn
                map('n', '<leader>gth', function()
                    vim.cmd('Gitsigns toggle_numhl')
                    vim.cmd('Gitsigns toggle_signs')
                end, { desc = 'Toggle number column and signcolumn highlighting.' })

                -- turn on inline diff preview of hunk
                map('n', '<leader>gd', function()
                    vim.cmd('Gitsigns preview_hunk_inline')
                end, { desc = 'Preview hunk inline.' })

                -- turn on git blame
                map('n', '<leader>gtb', function()
                    vim.cmd('Gitsigns toggle_current_line_blame')
                end, { desc = 'Toggle current line blame.' })

                map('n', '<leader>gb', function()
                    vim.cmd('Gitsigns blame_line')
                end, { desc = 'Preview git blame in a floating window.' })
            end
        })
    end
}
