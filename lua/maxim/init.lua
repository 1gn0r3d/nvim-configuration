require("maxim.set")
require("maxim.remap")

require("maxim.lazy_init")

-- terminal settings
local powershell_options = {
    shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
    shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
}

for option, value in pairs(powershell_options) do
    vim.opt[option] = value
end

local autocmd = vim.api.nvim_create_autocmd
local maxim = vim.api.nvim_create_augroup("maxim", {})

autocmd('LspAttach', {
    group = maxim,
    callback = function(e)
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
            { buffer = e.buf, desc = "Go to definition." })
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end,
            { buffer = e.buf, desc = "Hover and view documentation." })
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end,
            { buffer = e.buf, desc = "Search workspace symbols." })
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end,
            { buffer = e.buf, desc = "Open floating diagnostics." })
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end,
            { buffer = e.buf, desc = "Open code actions." })
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end,
            { buffer = e.buf, desc = "List all references." })
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end,
            { buffer = e.buf, desc = "Rename symbol." })
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end,
            { buffer = e.buf, desc = "Signature help." })
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end,
            { buffer = e.buf, desc = "Go to next diagnostic." })
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end,
            { buffer = e.buf, desc = "Go to previous diagnostic." })
        vim.keymap.set("n", "[e", function()
            vim.diagnostic.goto_next(
                { severity = vim.diagnostic.severity.ERROR })
        end, { buffer = e.buf, desc = "Go to next error." })
        vim.keymap.set("n", "]e", function()
            vim.diagnostic.goto_prev(
                { severity = vim.diagnostic.severity.ERROR })
        end, { buffer = e.buf, desc = "Go to previous error." })
    end
})
