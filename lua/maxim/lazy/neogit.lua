return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim"
    },
    config = function()
        local neogit = require('neogit')
        neogit.setup()

        -- set keymaps
        vim.keymap.set("n", "<leader>gs", function()
            neogit.open({ kind = 'auto' })
        end, { desc = "Open Neogit window." })

        -- The next section tries to set up keymaps only when the buffer is a NeogitStatus buffer.
        -- This is however not working because the fileytpe is only set afte the BuffWinEnter
        -- has allready been triggered
        --        local neogit_augroup = vim.api.nvim_create_augroup("Neogit", {})
        --        local autocmd = vim.api.nvim_create_autocmd
        --        autocmd("BufWinEnter", {
        --            group = neogit_augroup,
        --            pattern = "*",
        --            callback = function()
        --                if vim.bo.ft ~= "NeogitStatus" then
        --                    return
        --                end
        --                print("Buffer is a NeogitStatus buffer.")
        --
        --                local bufnr = vim.api.nvim_get_current_buf()
        --
        --                vim.keymap.set("n", "<leader>p", function()
        --                    print("Push shortcut working from NeogitStatus buffer.")
        --                    --vim.cmd.Git("push")
        --                end, { buffer = bufnr, remap = false, desc = "Git push." })
        --
        --                -- rebase always
        --                vim.keymap.set("n", "<leader>P", function()
        --                    vim.cmd.Git({ "pull", "--rebase" })
        --                end, { buffer = bufnr, remap = false, desc = "Git rebase." })
        --
        --                -- NOTE: It allows me to easily set the branch i am pushing and any tracking
        --                -- needed if i did not set the branch up correctly
        --                vim.keymap.set("n", "<leader>t", ":Git push -u origin ",
        --                    { buffer = bufnr, remap = false, desc = "Git push u- origin." })
        --            end
        --        })
    end,
}
