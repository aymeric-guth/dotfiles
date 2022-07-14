local status_ok, handlers = pcall(require, "av.handlers")
if not status_ok then
	return
end

local handlers = require("av.handlers")
local on_attach = handlers.on_attach
local capabilities = handlers.capabilities
local lsp_flags = handlers.lsp_flags

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

lspconfig["pyright"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	lsp_flags = lsp_flags,
	settings = {
		enabled = false,
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
		},
	},
})
