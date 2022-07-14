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

lspconfig["taplo"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	lsp_flags = lsp_flags,
	--settings = {
	--	taplo = {},
	--},
})
