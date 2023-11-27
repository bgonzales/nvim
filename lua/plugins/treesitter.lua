return {
    'nvim-treesitter/nvim-treesitter',
    version = false,
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
    cmd = { "TSUpdateSync" },
    keys = {
        { "<c-space>", desc = "Increment selection" },
        { "<bs>", desc = "Decrement selection", mode = "x" },
    },
	opts = {
		highlight = { enable = true },
		indent = { enable = true, disable = { 'python' } },
		ensure_installed = { 
            'bash', 'c', 'cpp', 
            'css', 'javascript', 'html', 'typescript', 'tsx',
            'swift', 'python', 'kotlin', 'latex',
            'lua', 'luadoc', 'luap',
            'markdown', 'markdown_inline', 'json',
            'vim', "vimdoc",
            'yaml', 
        },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		}
	},
    config = function(_, opts)
        if type(opts.ensure_installed) == "table" then
            local added = {}
            opts.ensure_installed = vim.tbl_filter(function(lang)
                if added[lang] then
                    return false
                end
                added[lang] = true
                return true
            end, opts.ensure_installed)
        end

        require("nvim-treesitter.configs").setup(opts)
    end
}
