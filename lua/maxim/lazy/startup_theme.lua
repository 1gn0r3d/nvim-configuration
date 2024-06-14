return {
    "goolord/alpha-nvim",
    requires = {
        "nvim-tree/nvim-web-devicons",
        "nvim-lua/plenary.nvim",
    },
    opts = function()
        local dashboard = require("alpha.themes.dashboard")
        local colors = require('maxim.lualine_theme.colors')

        -- Define the highlight groups locally
        vim.api.nvim_set_hl(0, 'AlphaNeovimLogoBlue', { fg = colors['blue'] })
        vim.api.nvim_set_hl(0, 'AlphaNeovimLogoGreen', { fg = colors['green'] })
        vim.api.nvim_set_hl(0, 'AlphaNeovimLogoGreenFBlueB', { fg = colors['green'], bg = colors['blue'] })


        local logo = {
            [[ ███       ███ ]],
            [[████      ████]],
            [[██████     █████]],
            [[███████    █████]],
            [[████████   █████]],
            [[█████████  █████]],
            [[█████ ████ █████]],
            [[█████  █████████]],
            [[█████   ████████]],
            [[█████    ███████]],
            [[█████     ██████]],
            [[████      ████]],
            [[ ███       ███ ]],
            [[                  ]],
            [[ N  E  O  V  I  M ]],
        }
        local logo_hl = {
            { { "AlphaNeovimLogoBlue", 0, 0 },  { "AlphaNeovimLogoGreen", 1, 14 },        { "AlphaNeovimLogoBlue", 23, 34 }, },
            { { "AlphaNeovimLogoBlue", 0, 2 },  { "AlphaNeovimLogoGreenFBlueB", 2, 4 },   { "AlphaNeovimLogoGreen", 4, 19 },        { "AlphaNeovimLogoBlue", 27, 40 }, },
            { { "AlphaNeovimLogoBlue", 0, 4 },  { "AlphaNeovimLogoGreenFBlueB", 4, 7 },   { "AlphaNeovimLogoGreen", 7, 22 },        { "AlphaNeovimLogoBlue", 29, 42 }, },
            { { "AlphaNeovimLogoBlue", 0, 8 },  { "AlphaNeovimLogoGreenFBlueB", 8, 10 },  { "AlphaNeovimLogoGreen", 10, 25 },       { "AlphaNeovimLogoBlue", 31, 44 }, },
            { { "AlphaNeovimLogoBlue", 0, 10 }, { "AlphaNeovimLogoGreenFBlueB", 10, 13 }, { "AlphaNeovimLogoGreen", 13, 28 },       { "AlphaNeovimLogoBlue", 33, 46 }, },
            { { "AlphaNeovimLogoBlue", 0, 13 }, { "AlphaNeovimLogoGreen", 14, 31 },       { "AlphaNeovimLogoBlue", 35, 49 }, },
            { { "AlphaNeovimLogoBlue", 0, 13 }, { "AlphaNeovimLogoGreen", 16, 32 },       { "AlphaNeovimLogoBlue", 35, 49 }, },
            { { "AlphaNeovimLogoBlue", 0, 13 }, { "AlphaNeovimLogoGreen", 17, 33 },       { "AlphaNeovimLogoBlue", 35, 49 }, },
            { { "AlphaNeovimLogoBlue", 0, 13 }, { "AlphaNeovimLogoGreen", 18, 34 },       { "AlphaNeovimLogoGreenFBlueB", 33, 35 }, { "AlphaNeovimLogoBlue", 35, 49 }, },
            { { "AlphaNeovimLogoBlue", 0, 13 }, { "AlphaNeovimLogoGreen", 19, 35 },       { "AlphaNeovimLogoGreenFBlueB", 34, 35 }, { "AlphaNeovimLogoBlue", 35, 49 }, },
            { { "AlphaNeovimLogoBlue", 0, 13 }, { "AlphaNeovimLogoGreen", 20, 36 },       { "AlphaNeovimLogoGreenFBlueB", 35, 37 }, { "AlphaNeovimLogoBlue", 37, 49 }, },
            { { "AlphaNeovimLogoBlue", 0, 13 }, { "AlphaNeovimLogoGreen", 21, 37 },       { "AlphaNeovimLogoGreenFBlueB", 36, 37 }, { "AlphaNeovimLogoBlue", 37, 49 }, },
            { { "AlphaNeovimLogoBlue", 1, 13 }, { "AlphaNeovimLogoGreen", 20, 35 },       { "AlphaNeovimLogoBlue", 37, 48 }, },
            {},
            { { "AlphaNeovimLogoGreen", 0, 9 }, { "AlphaNeovimLogoBlue", 9, 18 }, },
        }

        local logo2 = {
            [[                       .,,uod8B8bou,,.                             ]],
            [[              ..,uod8BBBBBBBBBBBBBBBBRPFT?l!i:.                    ]],
            [[         ,=m8BBBBBBBBBBBBBBBRPFT?!||||||||||||||                   ]],
            [[         !...:!TVBBBRPFT||||||||||!!^^""'   ||||                   ]],
            [[         !.......:!?|||||!!^^""'            ||||                   ]],
            [[         !.........||||                     ||||                   ]],
            [[         !.........||||  ##                 ||||                   ]],
            [[         !.........||||                     ||||                   ]],
            [[         !.........||||                     ||||                   ]],
            [[         !.........||||                     ||||                   ]],
            [[         !.........||||                     ||||                   ]],
            [[         `.........||||                    ,||||                   ]],
            [[          .;.......||||               _.-!!|||||                   ]],
            [[   .,uodWBBBBb.....||||       _.-!!|||||||||!:'                    ]],
            [[!YBBBBBBBBBBBBBBb..!|||:..-!!|||||||!iof68BBBBBb....               ]],
            [[!..YBBBBBBBBBBBBBBb!!||||||||!iof68BBBBBBRPFT?!::   `.             ]],
            [[!....YBBBBBBBBBBBBBBbaaitf68BBBBBBRPFT?!:::::::::     `.           ]],
            [[!......YBBBBBBBBBBBBBBBBBBBRPFT?!::::::;:!^"`;:::       `.         ]],
            [[!........YBBBBBBBBBBRPFT?!::::::::::^''...::::::;         iBBbo.   ]],
            [[`..........YBRPFT?!::::::::::::::::::::::::;iof68bo.      WBBBBbo. ]],
            [[  `..........:::::::::::::::::::::::;iof688888888888b.     `YBBBP^']],
            [[    `........::::::::::::::::;iof688888888888888888888b.     `     ]],
            [[      `......:::::::::;iof688888888888888888888888888888b.         ]],
            [[        `....:::;iof688888888888888888888888888888888899fT!        ]],
            [[          `..::!8888888888888888888888888888888899fT|!^"'          ]],
            [[            `' !!988888888888888888888888899fT|!^"'                ]],
            [[                `!!8888888888888888899fT|!^"'                      ]],
            [[                  `!988888888899fT|!^"'                            ]],
            [[                    `!9899fT|!^"'                                  ]],
            [[                      `!^"'                                        ]],
        }
        local logo2_hl = {}
        dashboard.section.header.val = logo
        dashboard.section.header.opts.hl = logo_hl
        dashboard.section.buttons.val = {
            dashboard.button("f", "  " .. "Find files", "<CMD>Telescope find_files<CR>"),
            dashboard.button("p", "  " .. "Open project folder", "<CMD>Oil<CR>"),
            dashboard.button("h", "  " .. "Open Harpoon quicklist",
                "<CMD>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<CR>"
            ),
        }

        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "AlphaNeovimLogoBlue"
            button.opts.hl_shortcut = "AlphaNeovimLogoGreen"
        end

        return dashboard
    end,
    config = function(_, dashboard)
        require("alpha").setup(dashboard.opts)
    end,
}
