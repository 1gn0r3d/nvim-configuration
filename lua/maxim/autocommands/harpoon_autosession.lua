local harpoon = require("harpoon")
local autosession = require("auto-session")

-- Function which updates the Harpoon CWD when the cwd is changed
local function update_harpoon_cwd()
    local cwd = vim.fn.getcwd()
    harpoon.set_project_cwd(cwd)
end

-- Autocommand to update Harpoon CWD on session restore
local harpoon_augroup = vim.api.nvim_create_augroup("HarpoonCwd", { clear = true })

vim.api.nvim_create_autocmd("User", {
    pattern = "SessionLoadPost",
    group = harpoon_augroup,
    callback = function()
        update_harpoon_cwd()
    end,
})

