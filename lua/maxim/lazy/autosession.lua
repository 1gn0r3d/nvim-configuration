return {
    "rmagatti/auto-session",
    config = function()
        require("auto-session").setup({
            log_level = "error",
            auto_session_supress_dirs = { "~/", "~/Downloads" },
            session_lens = {
                buftypes_to_ignore = {},
                load_on_setup = true,
                theme_conf = { border = true },
                previewer = false,
            },
        })

        -- Set mapping for searching a session.
        -- ⚠️ This will only work if Telescope.nvim is installed
        vim.keymap.set("n", "<leader>S", require("auto-session.session-lens").search_session, {
            noremap = true,
        })
    end
}
