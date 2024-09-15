return {
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { zindex = 100 })
			end,
		},
		init = function()
			vim.notify = require("notify")
		end,
	},
	-- FIXME: Fix conflict when launching code actions and creating a file using file browser, direction of input goes on top of screen
	-- {
	-- 	"stevearc/dressing.nvim",
	-- 	lazy = true,
	-- 	init = function()
	-- 		---@diagnostic disable-next-line: duplicate-set-field
	-- 		vim.ui.select = function(...)
	-- 			require("lazy").load({ plugins = { "dressing.nvim" } })
	-- 			return vim.ui.select(...)
	-- 		end
	-- 		---@diagnostic disable-next-line: duplicate-set-field
	-- 		vim.ui.input = function(...)
	-- 			require("lazy").load({ plugins = { "dressing.nvim" } })
	-- 			return vim.ui.input(...)
	-- 		end
	-- 	end,
	-- },

	-- FIXME: Noice not working as expected with code_actions (dressing)
	-- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
	-- {
	-- 	"folke/noice.nvim",
	-- 	enabled = false, -- TODO: code_action is not working as expected
	-- 	event = "VeryLazy",
	-- 	dependencies = {
	-- 		{ "MunifTanjim/nui.nvim", lazy = true },
	-- 	},
	-- 	opts = {
	-- 		lsp = {
	-- 			override = {
	-- 				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	-- 				["vim.lsp.util.stylize_markdown"] = true,
	-- 				["cmp.entry.get_documentation"] = true,
	-- 			},
	-- 		},
	-- 		routes = {
	-- 			{
	-- 				filter = {
	-- 					event = "msg_show",
	-- 					any = {
	-- 						{ find = "%d+L, %d+B" },
	-- 						{ find = "; after #%d+" },
	-- 						{ find = "; before #%d+" },
	-- 					},
	-- 				},
	-- 				view = "mini",
	-- 			},
	-- 		},
	-- 		presets = {
	-- 			bottom_search = false, -- use a classic bottom cmdline for search
	-- 			command_palette = false, -- position the cmdline and popupmenu together
	-- 			long_message_to_split = true, -- long messages will be sent to a split
	-- 			inc_rename = false, -- enables an input dialog for inc-rename.nvim
	-- 			lsp_doc_border = true, -- add a border to hover docs and signature help
	-- 		},
	-- 	},
	-- 	keys = {
	-- 		-- { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
	-- 		-- { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
	-- 		-- { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
	-- 		-- { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
	-- 		-- { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
	-- 		-- { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
	-- 		-- { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
	-- 	},
	-- },

	-- Run :h bufferline-configuration for options
	{
		"akinsho/bufferline.nvim",
		dependencies = {
			{ 'echasnovski/mini.bufremove', version = false },
		},
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
			{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
			{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
			{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
			{ "[t", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
			{ "]t", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
		},
		opts = {
			options = {
				-- stylua: ignore
				close_command = function(n) require("mini.bufremove").delete(n, false) end,
				-- stylua: ignore
				right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
				mode = "tabs", -- "buffers" | "tabs" to only show one of them
				-- diagnostics = "nvim_lsp",
				diagnostics = false,
				always_show_bufferline = false,
				diagnostics_indicator = function(_, _, diag)
					local icons = require("config.icons").icons.diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
					.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "left",
						separator = true,
						-- filetype = "neo-tree",
						-- text = "Neo-tree",
						-- highlight = "Directory",
						-- text_align = "left",
					},
				},
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
			-- Fix bufferline when restoring a session
			vim.api.nvim_create_autocmd("BufAdd", {
				callback = function()
					vim.schedule(function()
						pcall(nvim_bufferline)
					end)
				end,
			})
		end,
	},
}
