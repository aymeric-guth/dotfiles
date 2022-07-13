local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local null_ls_opts = {
	formatting.astyle.with({
		filetypes = { "c", "cpp" },
		extra_args = { "--options=${DOTCONF}/.astylerc", "--project=none" },
	}),
	diagnostics.cppcheck.with({
		filetypes = { "c", "cpp" },
		--            --cppcheck-build-dir=path
		extra_args = {
			"--enable=all",
			"--suppress=missingIncludeSystem",
			-- "--enable=warning,style,performance,portability,information,unusedFunction,missingInclude",
			"--std=c11",
			"--platform=unix64",
			"$FILENAME",
		},
	}),
	formatting.black.with({
		filetypes = { "python" },
		extra_args = { "--fast" },
	}),
	formatting.remark.with({
		filetypes = { "markdown" },
		extra_args = { "$FILENAME" },
	}),
	formatting.prettierd.with({
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
			"css",
			"scss",
			"less",
			"html",
			"json",
			"jsonc",
			"yaml",
			"markdown",
			"graphql",
			"handlebars",
		},
		extra_args = { "$FILENAME" },
	}),
	formatting.stylua,
}

--null_ls.setup({
--	debug = false,
--	source = null_ls_opts,
--})
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
	debug = false,
	sources = null_ls_opts,
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWrite", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					-- vim.lsp.buf.format({ bufnr = bufnr })
					vim.lsp.buf.formatting_sync()
				end,
			})
		end
	end,
})
