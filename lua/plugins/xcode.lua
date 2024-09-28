return {
	{
		"wojciech-kulik/xcodebuild.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"MunifTanjim/nui.nvim",
			-- "nvim-tree/nvim-tree.lua", -- (optional) to manage project files
			-- "stevearc/oil.nvim",       -- (optional) to manage project files
			"nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
		},
		config = function()
			require("xcodebuild").setup({
				-- put some options here or leave it empty to use default settings
			})
		end,
		keys = {
			{ "<leader>xc", "<CMD>XcodebuildPicker<CR>", desc = "Show Xcodebuild Actions"},
			{ "<leader>xb", "<CMD>XcodebuildBuild<CR>", desc = "Build project"},
			{ "<leader>xr", "<CMD>XcodebuildBuildRun<CR>", desc = "Build and run project"},
		}
	}
}
