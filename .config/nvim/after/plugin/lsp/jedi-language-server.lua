local handlers = require("av.handlers")
local on_attach = handlers.on_attach
local capabilities = handlers.capabilities
local lsp_flags = handlers.lsp_flags

require("lspconfig")["jedi_language_server"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	lsp_flags = lsp_flags,
	settings = {
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
	},
})
