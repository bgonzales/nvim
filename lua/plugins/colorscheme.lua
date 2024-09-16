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
			"ellisonleao/gruvbox.nvim",
			"talha-akram/noctis.nvim"
		},
		config = function()
			if vim.loop.os_uname().sysname == "Darwin" then
				require('auto-dark-mode').setup {
					set_dark_mode = function()
						vim.api.nvim_set_option_value('background', 'dark', {})
						-- vim.cmd([[colorscheme tokyonight]])
						vim.cmd([[colorscheme catppuccin]])
					end,
					set_light_mode = function()
						vim.api.nvim_set_option_value('background', 'light', {})
						-- Xcode color scheme
						-- vim.cmd([[colorscheme xcodelight]])

						-- Noctis configuration
						vim.cmd([[colorscheme noctis_hibernus]])
						-- vim.cmd([[colorscheme noctis_lilac]])
						vim.cmd([[highlight LineNr guibg=NONE gui=NONE cterm=NONE]])
					end,
				}
				require("auto-dark-mode").init()
			elseif vim.loop.os_uname().sysname == "Linux" then
				vim.api.nvim_set_option_value('background', 'dark', {})
				vim.cmd([[colorscheme catppuccin]])
			else
				vim.api.nvim_set_option_value('background', 'light', {})
				vim.cmd([[colorscheme xcodelighthc]])
			end
		end
	}
}
