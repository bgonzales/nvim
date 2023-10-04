return {
    {
        "f-person/auto-dark-mode.nvim",
        lazy = false,
        priority = 1000,
        dependencies = {
            {
                "catppuccin/nvim",
                name = "catppuccin",
                -- Colorscheme options: catppuccin-{latte,frappe,macchiato,mocha}
                background = {
                    light = "latte",
                    dark = "macchiato",
                },
                opts = {
                    no_bold = false,
                }
            },
            -- Colorscheme options: tokyonight-{night,storm,day,moon}
            "folke/tokyonight.nvim",
            "ellisonleao/gruvbox.nvim"
        },
        config = function()
            if vim.loop.os_uname().sysname == "Darwin" then
                require('auto-dark-mode').setup {
                    set_dark_mode = function()
                        vim.api.nvim_set_option('background', 'dark')
                        vim.cmd([[colorscheme tokyonight]])
                    end,
                    set_light_mode = function()
                        vim.api.nvim_set_option('background', 'light')
                        vim.cmd([[colorscheme catppuccin]])
                    end,
                }
                require("auto-dark-mode").init()
            elseif vim.loop.os_uname().sysname == "Linux" then
                vim.api.nvim_set_option('background', 'dark')
                vim.cmd([[colorscheme catppuccin]])
            else
                vim.api.nvim_set_option('background', 'light')
                vim.cmd([[colorscheme xcodelighthc]])
            end
        end
    }
}