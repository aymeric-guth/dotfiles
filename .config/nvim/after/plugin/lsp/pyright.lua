local handlers = require("av.handlers")
local on_attach = handlers.on_attach
local capabilities = handlers.capabilities
local lsp_flags = handlers.lsp_flags

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
