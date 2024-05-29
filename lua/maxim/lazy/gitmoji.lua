return {
    "zakissimo/smoji.nvim",
    config = function()
        require("smoji")

        local conf = require("telescope.config").values
        local smoji_list = require("smoji").items

        local function toggle_telescope(gitmoji_list)
            -- Set up the Telescope picker
            require("telescope.pickers").new({}, {
                prompt_title = "Pick gitmoji",
                finder = require("telescope.finders").new_table({
                    results = gitmoji_list,
                    entry_maker = function(entry)
                        return {
                            value = entry,
                            display = entry,
                            ordinal = entry,
                        }
                    end,
                }),
                sorter = conf.generic_sorter({}),
                attach_mappings = function(prompt_bufnr)
                    local actions = require("telescope.actions")
                    local action_state = require("telescope.actions.state")

                    -- On selection, insert the chosen gitmoji
                    actions.select_default:replace(function()
                        actions.close(prompt_bufnr)
                        local selection = action_state.get_selected_entry()
                        if selection then
                            local s = vim.split(selection.value, '-')
                            vim.cmd('normal! i[' .. s[1] .. s[#s] .. ']' .. '\r\r')
                        end
                    end)

                    return true
                end,
            }):find()
        end

        -- Binding the toggle_telescope function to a keymap
        vim.keymap.set("n", "<leader>gm", function()
            -- Replace 'gitmoji_list' with the actual reference to your gitmoji list
            toggle_telescope(smoji_list)
        end, { desc = "Select gitmoji." })

        -- Set up autocommand for vim fugitive (to insert gitmojo at start of git message)
        -- local autocmd = vim.api.nvim_create_autocmd
        -- local augroup = vim.api.nvim_create_augroup("Gitmoji", { clear = true })
        -- autocmd("FileWrite", {
        --     group = augroup,
        --     pattern = "COMMIT_EDITMSG",
        --     callback = function()
        --         vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
        --         vim.schedule(function()
        --             toggle_telescope(smoji_list)
        --         end)
        --     end
        -- })
    end
}
