return {
    "rmagatti/auto-session",
    config = function()
        require("auto-session").setup({
            log_level = "error",
            auto_session_supress_dirs = { "~/", "~/Downloads" }
        })
    end,
}
