return {
    "folke/trouble.nvim",
    config = function()
        require("trouble").setup({
            -- icons = true,
            -- icons = false,
        })
        local trouble = require("trouble")
        local last_trouble_options = nil

        local function reopen_trouble(opts)
            -- if trouble is open, and the options are different,
            -- close trouble, then reopen
            if trouble.is_open() and last_trouble_options == opts then
                trouble.close()
            elseif trouble.is_open() and last_trouble_options ~= opts then
                trouble.close()
                trouble.open(opts)
                last_trouble_options = opts
                -- if trouble is open, and the options are the same,
                -- close trouble
            elseif not trouble.is_open() then
                trouble.open(opts)
                last_trouble_options = opts
            end
        end

        vim.keymap.set("n", "<leader>tt", function()
            trouble.toggle(last_trouble_options)
        end, { desc = "Open trouble window." })

        vim.keymap.set("n", "<leader>td", function()
            reopen_trouble("diagnostics")
        end, { desc = "Open all diagnistics." })

        vim.keymap.set("n", "<leader>te", function()
            reopen_trouble({ mode = "diagnostics", filter = { severity = vim.diagnostic.severity.ERROR } })
        end, { desc = "Open error diagnistics." })

        vim.keymap.set("n", "[t", function()
            trouble.next({ skip_groups = true, jump = true });
        end, { desc = "Next trouble entry." })

        vim.keymap.set("n", "]t", function()
            trouble.prev({ skip_groups = true, jump = true });
        end, { desc = "Previous trouble entry." })

        local autocmd = vim.api.nvim_create_autocmd

        vim.api.nvim_create_autocmd("QuickFixCmdPost", {
            callback = function()
                vim.cmd([[Trouble qflist open]])
            end,
        })

        -- Setup an autocommand which maps <leader>t*, while inside an oil window
        -- to go back to the previous buffer.
        local trouble_augroup = vim.api.nvim_create_augroup("trouble_augroup", { clear = true })
        local trouble_augroup = vim.api.nvim_create_augroup("trouble_augroup", { clear = true })
        autocmd("Filetype", {
            pattern = "trouble",
            group = trouble_augroup,
            callback = function()
                vim.keymap.set("n", "<leader>t", function()
                    trouble.toggle()
                end, { buffer = true, noremap = true, silent = true, desc = "Toggle trouble buffer." })
            end
        })
    end
}
