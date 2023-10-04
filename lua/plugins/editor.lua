return {
    { "nvim-lua/plenary.nvim", lazy = true },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
        "nvim-pack/nvim-spectre",
        cmd = "Spectre",
        opts = { open_cmd = "noswapfile vnew" },
        keys = {
            { "<leader>sr", '<CMD>lua require("spectre").toggle()<CR>', desc = "Replace in files (Spectre)" },
        },
    },
    {
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
		    signcolumn = true,
			numhl = false,
			linehl = false,
			word_diff = false,
			current_line_blame = false,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 50,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

				map("n", "]c", gs.next_hunk, "Jump to next git change")
				map("n", "[c", gs.prev_hunk, "Jump to prev git change")
				map("n", "<leader>gg", gs.preview_hunk, "Preview hunk")
				map("n", "<leader>gb", "<CMD>Gitsigns toggle_current_line_blame<CR>", "[G]it [B]lame")
				map("n", "<leader>gd", gs.diffthis, "[G]it [D]iff")
			end,
		},
	},
}