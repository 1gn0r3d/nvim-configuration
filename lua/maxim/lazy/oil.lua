return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup {
            columns = {
                "ctime",
                "icon",
            },
            skip_confirms_for_simple_edits = true,
            keymaps = {
                ["<C-h>"] = false,
                ["<C-l>"] = false,
                ["M-h"] = "actions.select_split",
            },
            view_options = {
                show_hidden = true,
                natural_order = true,
                is_always_hidden = function(name, _)
                    return name == ".git"
                end,
            },
            win_options = {
                wrap = true,
            },
            float = {
                padding = 3,
            }
        }
        -- Open parent directory in current window
        vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory." })

        -- Open parent directory in floating window
        vim.keymap.set("n", "<leader>-", require("oil").toggle_float,
            { desc = "Open parent directory in floating window." })

        -- Setup an autocommand which maps <leader>pv while inside an oil window
        -- to go back to the previous buffer.
        local oil_augroup = vim.api.nvim_create_augroup("oil_augroup", { clear = true })
        local autocmd = vim.api.nvim_create_autocmd
        autocmd("Filetype", {
            pattern = "oil",
            group = oil_augroup,
            callback = function()
                vim.api.nvim_buf_set_keymap(0, "n", "<ESC>", "<CMD>q<CR>",
                    { noremap = true, silent = true, desc = "Close oil buffer." })
                vim.api.nvim_buf_set_keymap(0, "n", "<leader>pv", "<CMD>b#<CR>",
                    { noremap = true, silent = true, desc = "Return to previously opened buffer." })
            end
        })
    end,
}
