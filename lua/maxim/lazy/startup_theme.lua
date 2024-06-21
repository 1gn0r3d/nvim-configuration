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

        local logos = {
            {
                logo = {
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
                },
                colormap = {
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
                },
                weight = 4,
            },
            {
                logo = {
                    [[                       .,,uod8B8bou,,.                             ]],
                    [[              ..,uod8BBBBBBBBBBBBBBBBRPFT?l!i:.                    ]],
                    [[         ,=m8BBBBBBBBBBBBBBBRPFT?!||||||||||||||                   ]],
                    [[         !...:!TVBBBRPFT||||||||||!!^^""'   ||||                   ]],
                    [[         !.......:!?|||||!!^^""'            ||||                   ]],
                    [[         !.........||||             ||      ||||                   ]],
                    [[         !.........||||      ||\\   ||      ||||                   ]],
                    [[         !.........||||      || \\  ||      ||||                   ]],
                    [[         !.........||||      ||  \\ ||      ||||                   ]],
                    [[         !.........||||      ||   \\||      ||||                   ]],
                    [[         !.........||||      ||    \||      ||||                   ]],
                    [[         `.........||||      ||            ,||||                   ]],
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
                },
                colormap = {
                    { { "AlphaNeovimLogoGreen", 23, 38 }, },
                    { { "AlphaNeovimLogoGreen", 14, 47 }, },
                    { { "AlphaNeovimLogoBlue", 9, 10 },   { "AlphaNeovimLogoGreen", 10, 34 }, },
                    { { "AlphaNeovimLogoBlue", 9, 13 },   { "AlphaNeovimLogoGreen", 13, 24 }, },
                    { { "AlphaNeovimLogoBlue", 9, 17 },   { "AlphaNeovimLogoGreen", 17, 20 }, },
                    { { "AlphaNeovimLogoBlue", 9, 19 },   { "AlphaNeovimLogoGreen", 19, 19 }, { "AlphaNeovimLogoGreen", 29, 42 }, },
                    { { "AlphaNeovimLogoBlue", 9, 19 },   { "AlphaNeovimLogoGreen", 19, 19 }, { "AlphaNeovimLogoGreen", 29, 42 }, },
                    { { "AlphaNeovimLogoBlue", 9, 19 },   { "AlphaNeovimLogoGreen", 19, 19 }, { "AlphaNeovimLogoGreen", 29, 42 }, },
                    { { "AlphaNeovimLogoBlue", 9, 19 },   { "AlphaNeovimLogoGreen", 19, 19 }, { "AlphaNeovimLogoGreen", 29, 42 }, },
                    { { "AlphaNeovimLogoBlue", 9, 19 },   { "AlphaNeovimLogoGreen", 19, 19 }, { "AlphaNeovimLogoGreen", 29, 42 }, },
                    { { "AlphaNeovimLogoBlue", 9, 19 },   { "AlphaNeovimLogoGreen", 19, 19 }, { "AlphaNeovimLogoGreen", 29, 42 }, },
                    { { "AlphaNeovimLogoBlue", 9, 19 },   { "AlphaNeovimLogoGreen", 19, 19 }, { "AlphaNeovimLogoGreen", 29, 42 }, },
                    { { "AlphaNeovimLogoGreen", 10, 11 }, { "AlphaNeovimLogoBlue", 11, 19 },  { "AlphaNeovimLogoGreen", 19, 19 }, },
                    { { "AlphaNeovimLogoGreen", 3, 14 },  { "AlphaNeovimLogoBlue", 14, 19 },  { "AlphaNeovimLogoGreen", 19, 19 }, { "AlphaNeovimLogoGreen", 49, 68 }, },
                    { { "AlphaNeovimLogoBlue", 0, 1 },    { "AlphaNeovimLogoGreen", 1, 19 },  { "AlphaNeovimLogoBlue", 19, 19 },  { "AlphaNeovimLogoGreen", 19, 19 }, { "AlphaNeovimLogoGreen", 37, 48 }, { "AlphaNeovimLogoGreen", 49, 68 }, },
                    { { "AlphaNeovimLogoBlue", 0, 3 },    { "AlphaNeovimLogoGreen", 3, 19 },  { "AlphaNeovimLogoGreen", 30, 47 }, { "AlphaNeovimLogoGreen", 49, 68 }, },
                    { { "AlphaNeovimLogoBlue", 0, 5 },    { "AlphaNeovimLogoGreen", 5, 40 },  { "AlphaNeovimLogoGreen", 49, 68 }, },
                    { { "AlphaNeovimLogoBlue", 0, 7 },    { "AlphaNeovimLogoGreen", 7, 33 },  { "AlphaNeovimLogoBlue", 42, 46 },  { "AlphaNeovimLogoGreen", 49, 68 }, },
                    { { "AlphaNeovimLogoBlue", 0, 9 },    { "AlphaNeovimLogoGreen", 9, 26 },  { "AlphaNeovimLogoBlue", 35, 42 },  { "AlphaNeovimLogoGreen", 49, 68 }, },
                    { { "AlphaNeovimLogoBlue", 0, 11 },   { "AlphaNeovimLogoGreen", 11, 19 }, { "AlphaNeovimLogoGreen", 44, 68 }, },
                    { { "AlphaNeovimLogoBlue", 1, 13 },   { "AlphaNeovimLogoGreen", 37, 68 }, },
                    { { "AlphaNeovimLogoBlue", 3, 13 },   { "AlphaNeovimLogoGreen", 30, 68 }, },
                    { { "AlphaNeovimLogoBlue", 5, 13 },   { "AlphaNeovimLogoGreen", 23, 68 }, },
                    { { "AlphaNeovimLogoBlue", 7, 13 },   { "AlphaNeovimLogoGreen", 17, 68 }, },
                    { { "AlphaNeovimLogoBlue", 9, 13 },   { "AlphaNeovimLogoGreen", 16, 68 }, },
                    { { "AlphaNeovimLogoBlue", 11, 13 },  { "AlphaNeovimLogoGreen", 16, 68 }, },
                    { { "AlphaNeovimLogoGreen", 0, 68 }, },
                    { { "AlphaNeovimLogoGreen", 0, 68 }, },
                    { { "AlphaNeovimLogoGreen", 0, 68 }, },
                    { { "AlphaNeovimLogoGreen", 0, 68 }, },
                },
                weight = 1,
            },
        }
        local function calculate_cumulative_weights(choices)
            local cumulative = {}
            local sum = 0
            for _, choice in ipairs(choices) do
                sum = sum + choice.weight
                table.insert(cumulative, sum)
            end
            return cumulative, sum
        end
        local function weighted_random_choice(choices)
            local cumulative_weights, total_weight = calculate_cumulative_weights(choices)
            local random_value = math.random() * total_weight
            for i, weight in ipairs(cumulative_weights) do
                if random_value <= weight then
                    return choices[i]
                end
            end
            return choices[#choices]
        end
        local selected_logo = weighted_random_choice(logos)
        dashboard.section.header.val = selected_logo.logo
        dashboard.section.header.opts.hl = selected_logo.colormap
        dashboard.section.buttons.val = {
            dashboard.button("h", "  " .. "Harpoon quicklist",
                "<CMD>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<CR>"
            ),
            dashboard.button("p", "  " .. "Project folder",
                "<CMD>lua require('oil').toggle_float()<CR>"
            ),
            dashboard.button("f", "  " .. "Find files", "<CMD>Telescope find_files<CR>"),
            dashboard.button("s", "  " .. "Search in files", "<CMD>Telescope live_grep<CR>"),
            dashboard.button("r", "  " .. "Recent files", "<CMD>Telescope oldfiles<CR>"),
            dashboard.button("v", "  " .. "VimBeGood", "<CMD>VimBeGood<CR>"),
            dashboard.button("b", "  " .. "Blackjack", "<CMD>BlackJackNewGame<CR>"),
            dashboard.button("t", "  " .. "Tetris", "<CMD>Tetris<CR>"),
            dashboard.button("q", "  " .. "Quit", "<CMD>qa!<CR>"),
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
