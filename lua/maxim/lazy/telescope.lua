return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "plenary",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            config = function()
                require("telescope").load_extension("fzf")
            end,
        },
    },
    config = function()
        require("telescope").setup({
            path_display = { "filename_first" },
            pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
                },
                live_grep = {
                    additional_args = function()
                        return { "--hidden", "--glob", "!**/.git/*" }
                    end,
                },
                grep_string = {
                    additional_args = function()
                        return { "--hidden", "--glob", "!**/.git/*" }
                    end,
                },
            },
        })

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files in project." })
        vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Find git tracked files in project." })
        vim.keymap.set("n", "<leader>pws", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, { desc = "Search for word under cursor in project." })
        vim.keymap.set("n", "<leader>pWs", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end, { desc = "Search for word (with brackets etc.) under cursor in project." })
        vim.keymap.set("n", "<leader>ps", function()
            builtin.live_grep({})
        end, { desc = "Search word in project." })
        vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "Search in help." })
    end,
}
