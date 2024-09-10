return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                key = function()
                    return vim.loop.cwd()
                end,
            },
        })

        -- Set up telescope
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        vim.keymap.set("n", "<leader>E", function()
            toggle_telescope(harpoon:list())
        end, { desc = "Open harpoon quicktogglelist in telescope." })
        vim.keymap.set("n", "<C-S-E>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Open harpoon quicktogglelist in telescope." })

        -- Set hotkeys to add to quicktoggle list
        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "Add current buffer to harpoon quicktoggle list." })
        -- Set hotkey for quicktoggle list
        vim.keymap.set("n", "<leader>e", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Open harpoon quicktoggle list." })
        vim.keymap.set("n", "<c-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Open harpoon quicktoggle list." })

        -- Set hotkeys for the first four spots in the quicktoggle list
        vim.keymap.set("n", "<C-o>", function()
            harpoon:list():prev()
            -- harpoon:list():select(1)
        end, { desc = "Previous harpoon quicktoggle list item.", noremap = true })
        vim.keymap.set("n", "<C-p>", function()
            harpoon:list():next()
            -- harpoon:list():select(2)
        end, { desc = "Next harpoon quicktoggle list item.", noremap = true })

        -- Setup autocommands to change the cwd when the directory is switched (for session manager)
        -- Autocommand is not working yet


        -- local function update_harpoon_cwd()
        --     local current_cwd = vim.vn.getcwd()
        --     harpoon.set_current_dir(current_cwd)
        -- end

        -- vim.api.nvim_create_augroup("HarpoonCwd", { clear = true })
        -- vim.api.nvim_create_autocmd("Dirchanged", {
        --     pattern = '*',
        --     group = "HarpoonCwd",
        --     callback = function()
        --         update_harpoon_cwd()
        --     end,
        -- })
    end,

}
