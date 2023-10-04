return {
    {
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		config = function()
			-- Custom lua snippets in `luasnippets` folder (by default)
			require("luasnip.loaders.from_lua").lazy_load()
		end,
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        keys = {
            {
              "<tab>",
              function()
                return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
              end,
              expr = true, silent = true, mode = "i",
            },
            { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
	},
	{
		'hrsh7th/nvim-cmp',
        version = false,
        event = "InsertEnter",
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
			'saadparwaiz1/cmp_luasnip',
		},
		opts = function()
			local cmp = require 'cmp'
			local luasnip = require 'luasnip'
			return {
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert {
					['<C-d>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<CR>'] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					},
					['<Tab>'] = cmp.mapping(function(fallback)
						if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
						end, { 'i', 's' }
					),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
						end, { 'i', 's' }
					),
				},
				sources = cmp.config.sources (
					{
						{ name = 'nvim_lsp' },
						{ name = 'luasnip' },
                        { name = "nvim_lua" },
						{ name = 'buffer' },
                        { name = 'path' },
					}
				),
				formatting = {
					format = function(entry, item)
						local icons = require("config.icons").icons.kinds
						if icons[item.kind] then
							item.kind = icons[item.kind] .. item.kind
						end
						item.menu = ({
							nvim_lsp = "[Lsp]",
							nvim_lua = "[Lua]",
							path = "[Path]",
							buffer = "[Buffer]",
							spell = "[Spell]",
							luasnip = "[Luasnip]",
						})[entry.source.name]
						return item
					end,
				},
				experimental = { ghost_text = true },
			}
		end
	},
    {
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				'williamboman/mason.nvim',
				config = function() require("mason").setup() end
			}, {
				"folke/neodev.nvim", -- Additional lua configuration for nvim
				config = function() require("neodev").setup() end
			},
			{
				"j-hui/fidget.nvim", -- Status updates at the bottom right corner
				config = function () require("fidget").setup() end
			},
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = true,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
				},
				severity_sort = true,
			},

			servers = {
				tailwindcss = {},
				tsserver = {},
				eslint = {},
				jsonls = {},
				texlab = {},
				cssls = {},
				html = {},
				clangd = {},
				docker_compose_language_service = {},
				dockerls = {},
				lua_ls = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
						diagnostics = { globals = {'vim'}, }
					},
				},
			},
		},

		config = function(_, opts)
			local on_attach = function (client, _)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer=0, desc='Hover Documentation'})
				vim.keymap.set('n', 'rn', vim.lsp.buf.rename, {buffer=0, desc='[R]ename'})
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer=0, desc='[G]o to [D]efinition'})
				vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format, {buffer=0, desc='[F]ormat [F]ile]'})
				vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {buffer=0, desc='[G]o to [R]eferences'})
				vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {buffer=0, desc='[C]ode [A]ction'})
				vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, {buffer=0, desc='[W]orkspace [S]ymbols'})
				vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, {buffer=0, desc='[D]ocument [S]ymbols'})
			end

			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

			local servers = opts.servers
			local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
			local have_mason, mason_lspconfig = pcall(require, "mason-lspconfig")

			if have_mason then
				mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })
				mason_lspconfig.setup_handlers {
					function(server_name)
						require('lspconfig')[server_name].setup {
							capabilities = capabilities,
							on_attach = on_attach,
							settings = servers[server_name],
						}
					end
				}
			end

			if vim.loop.os_uname().sysname == "Darwin" then
				-- Configure SourceKit LSP for Swift
				-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sourcekit
				-- https://github.com/apple/sourcekit-lsp
				local lsp_config = require('lspconfig')
				lsp_config.sourcekit.setup {
					on_attach = on_attach,
					capabilities = capabilities,
					filetypes = { "swift", "objective-c", "objective-cpp" },
					root_pattern = lsp_config.util.root_pattern("Package.swift", ".git")
				}
			end
		end,
	},
}