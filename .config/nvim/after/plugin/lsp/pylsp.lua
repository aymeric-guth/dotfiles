local handlers = require("av.handlers")
local on_attach = handlers.on_attach
local capabilities = handlers.capabilities
local lsp_flags = handlers.lsp_flags

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
