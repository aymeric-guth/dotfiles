local compare = require("cmp.config.compare")
local icons = require("av.icons")
local kind_icons = icons.kind

-- vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
-- vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
-- vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
-- vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })
-- vim.api.nvim_set_hl(0, "CmpItemKindLsp", { fg = "#6CC644" })
-- vim.api.nvim_set_hl(0, "CmpItemKindBuffer", { fg = "#CA42F0" })
-- vim.api.nvim_set_hl(0, "CmpItemKindPath", { fg = "#FDE030" })
-- vim.api.nvim_set_hl(0, "CmpItemKindLua", { fg = "#F64D00" })

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},

	window = {
		completion = {
			border = "rounded",
			winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
		},
		documentation = {
			border = "rounded",
			winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
		},
		experimental = {
			ghost_text = true,
		},
	},

	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),

	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item.kind = kind_icons[vim_item.kind]
			if entry.source.name == "cmp_tabnine" then
				vim_item.kind = icons.misc.TabNine
				vim_item.kind_hl_group = "CmpItemKindTabnine"
			end
			if entry.source.name == "copilot" then
				vim_item.kind = icons.git.Octoface
				vim_item.kind_hl_group = "CmpItemKindCopilot"
			end
			if entry.source.name == "emoji" then
				vim_item.kind = icons.misc.Smiley
				vim_item.kind_hl_group = "CmpItemKindEmoji"
			end
			if entry.source.name == "nvim_lsp" then
				vim_item.kind = icons.misc.Robot
				vim_item.kind_hl_group = "CmpItemKindLsp"
			end
			if entry.source.name == "buffer" then
				vim_item.kind = icons.misc.Buffer
				vim_item.kind_hl_group = "CmpItemKindBuffer"
			end
			if entry.source.name == "path" then
				vim_item.kind = icons.misc.Path
				vim_item.kind_hl_group = "CmpItemKindPath"
			end
			if entry.source.name == "nvim_lua" then
				vim_item.kind = icons.misc.Vim
				vim_item.kind_hl_group = "CmpItemKindLua"
			end

			vim_item.menu = ({
				nvim_lsp = "",
				nvim_lua = "",
				luasnip = "",
				buffer = "",
				path = "",
				emoji = "",
			})[entry.source.name]
			return vim_item
		end,
	},

	sources = {
		-- { name = "crates", group_index = 1 },
		{ name = "nvim_lsp", group_index = 1 },
		{ name = "nvim_lua", group_index = 1 },
		-- { name = "copilot", group_index = 2 },
		{ name = "cmp_tabnine", group_index = 2 },
		{ name = "luasnip", group_index = 3 },
		{ name = "buffer", group_index = 4 },
		{ name = "path", group_index = 4 },
		{ name = "emoji", group_index = 4 },
	},

	sorting = {
		priority_weight = 2,
		comparators = {
			-- require("copilot_cmp.comparators").prioritize,
			-- require("copilot_cmp.comparators").score,
			compare.offset,
			compare.exact,
			-- compare.scopes,
			compare.score,
			compare.recently_used,
			compare.locality,
			-- compare.kind,
			compare.sort_text,
			compare.length,
			compare.order,
			-- require("copilot_cmp.comparators").prioritize,
			-- require("copilot_cmp.comparators").score,
		},
	},
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "cmdline" },
	}),
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<leader>f", vim.lsp.buf.formatting, bufopts)

	if client.name ~= "null-ls" then
		client.resolved_capabilities.document_formatting = false
	end
	--if client.name == "null-ls" then
	--	client.server_capabilities.completionProvider = false
	--end
end

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

require("lspconfig").sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	lsp_flags = lsp_flags,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			format = { enable = false },
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = { enable = false },
		},
	},
})

require("lspconfig")["pyright"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	lsp_flags = lsp_flags,
	settings = {
		pyright = {
			disableLanguageServices = true,
			disableOrganizeImports = true,
		},
		python = {
			analysis = {
				autoImportCompletions = false,
				diagnosticMode = "workspace",
				--diagnosticSeverityOverrides = {}
				--extraPaths = {},
				--logLevel = "Information",
				--stubPath = {},
				--typeCheckingMode = "strict",
				--typeshedPaths = {},
				useLibraryCodeForTypes = true,
			},
			pythonPath = "./.venv/bin/python",
			venvPath = "./.venv",
		},
	},
})

require("lspconfig")["jedi_language_server"].setup({
	jedi = {
		enable = true,
		startupMessage = false,
		markupKindPreferred = "plaintext",
		trace = { server = "off" },
		jediSettings = {
			autoImportModules = {},
			caseInsensitiveCompletion = true,
			debug = false,
		},
		executable = {
			command = { "jedi-language-server" },
			args = {},
		},
		codeAction = {
			nameExtractFunction = "jls_extract_def",
			nameExtractVariable = "jls_extract_var",
		},
		completion = {
			disableSnippets = false,
			resolveEagerly = false,
			ignorePatterns = {},
		},
		diagnostics = {
			enable = true,
			didOpen = true,
			didChange = true,
			didSave = true,
		},
		hover = {
			enable = true,
			disable = {
				keyword = {
					all = false,
					names = {},
					fullNames = {},
				},
			},
		},
		workspace = {
			extraPaths = {},
			symbols = {
				maxSymbols = 20,
				ignoreFolders = {
					".nox",
					".tox",
					".venv",
					"__pycache__",
					"venv",
				},
			},
		},
	},
})

require("lspconfig")["pylsp"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	lsp_flags = lsp_flags,
	settings = {
		pylsp = {
			plugins = {
				configurationSources = {},
				flake8 = {
					config = "",
					enabled = false,
					exclude = {},
					executable = "",
					filename = "",
					hangClosing = false,
					ignore = {},
					maxLineLength = 0,
					perFileIgnores = {},
					select = {},
				},
				jedi = {
					extra_paths = {},
					env_vars = {},
					environment = "",
				},
				jedi_completion = {
					enabled = true,
					include_params = true,
					include_class_objects = true,
					fuzzy = true,
					eager = false,
					resolve_at_most_labels = 25,
					cache_labels_for = { "actors" },
				},
				jedi_definition = {
					enabled = true,
					follow_imports = true,
					follow_builtin_imports = true,
				},
				jedi_hover = { enabled = true },
				jedi_references = { enabled = true },
				jedi_signature_help = { enabled = true },
				jedi_symbols = {
					enabled = true,
					all_scopes = false,
					include_import_symbols = true,
				},
				mccabe = {
					enabled = false,
					threshold = 15,
				},
				preload = {
					enabled = false,
					modules = {},
				},
				pycodestyle = {
					enabled = false,
					exclude = {},
					filename = {},
					select = {},
					ignore = {},
					hangClosing = false,
					maxLineLength = 0,
				},
				pydocstyle = {
					enabled = false,
					convention = "",
					addIgnore = {},
					addSelect = {},
					ignore = {},
					select = {},
					match = "",
					matchDir = "",
				},
				pyflakes = { enabled = false },
				pylint = {
					enabled = false,
					args = {},
					executable = "",
				},
				rope_completion = {
					enabled = false,
					eager = false,
				},
				yapf = {
					enabled = false,
				},
				rope = {
					extensionModules = "",
					ropeFolder = {},
				},
				mypy = { enabled = false },
			},
		},
	},
})

require("lspconfig")["clangd"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	lsp_flags = lsp_flags,
})
require("null-ls")
