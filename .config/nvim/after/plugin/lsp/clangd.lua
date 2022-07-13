local handlers = require("av.handlers")
local on_attach = handlers.on_attach
local capabilities = handlers.capabilities
local lsp_flags = handlers.lsp_flags

require("lspconfig")["clangd"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	lsp_flags = lsp_flags,
})
