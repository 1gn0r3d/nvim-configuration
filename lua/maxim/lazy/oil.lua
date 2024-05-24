return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup {
            columns = {
                "ctime",
                "icon",
            },
            keymaps = {
                ["<C-h>"] = false,
                ["<C-l>"] = false,
                ["M-h"] = "actions.select_split",
            },
            view_options = {
                show_hidden = true,
            },
        }
        -- Setup a local function which opens the project view (parent directory) on a window to the right
        local function open_oil_in_right_split()
            local total_width = vim.o.columns
            local split_width = math.floor(total_width * .3)
            vim.cmd("vsplit")
            vim.cmd("wincmd l")
            vim.cmd("vertical resize " .. split_width)
            vim.cmd("Oil")
        end

        -- Open parent directory in current window
        vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory." })

        -- Open parent directory in a split to the right
        vim.keymap.set("n", "<leader>pV", open_oil_in_right_split,
            { desc = "Open parent directory in split to the right." })

        -- Open parent directory in floating window
        vim.keymap.set("n", "<leader>-", require("oil").toggle_float,
            { desc = "Open parent directory in floating window." })

        -- Setup an autocommand which maps <leader>pv while inside an oil window
        -- to go back to the previous buffer.
        local maxim = vim.api.nvim_create_augroup("maxim", {})
        local autocmd = vim.api.nvim_create_autocmd
        autocmd("Filetype", {
            pattern = "oil",
            callback = function()
                vim.api.nvim_buf_set_keymap(0, "n", "<leader>pv", ":b#<CR>",
                    { noremap = true, silent = true, desc = "Return to previously opened buffer." })
            end
        })
    end,
}
