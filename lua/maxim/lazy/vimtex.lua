return {
    {
        "lervag/vimtex",
        lazy = false,
        ft = { "tex", "cls" },
        init = function()
            vim.g.vimtex_view_general_viewer = 'SumatraPDF'
            vim.g.vimtex_view_general_options = [[--reuse-instance --forward-search @tex @pdf]]
            vim.g.vimtex_view_general_options_latexmk = [[--reuse-instance]]
            vim.g.vimtex_quickfix_ignore_filters = {
                'Underfull \\\\hbox',
                'Overfull \\\\hbox',
                'LaTeX Warning: .\\+ float specifier changed to',
                'LaTeX hooks Warning',
                'Package siunitx Warning: Detected the "physics" package:',
                'Package hyperref Warning: Token not allowed in a PDF string',
                'LaTeX Warning: Command \\\\underbar  has changed',
                'LaTeX Warning: Command \\\\underline  has changed',
                'Package biblatex Warning: Split bibliography detected',
                'LaTeX Warning: There were undefined references.',
            }
        end
    },
    {
        "windwp/nvim-ts-autotag",
        event = "VeryLazy",
    },
}
