require("null-ls").setup({
    debug = false,
    sources = {
        require("null-ls").builtins.formatting.astyle.with({
            filetypes = { "c", "cpp" },
            extra_args = { "--options=${DOTCONF}/.astylerc", "--project=none" },
        }),
        require("null-ls").builtins.diagnostics.cppcheck.with({
            filetypes = { "c", "cpp"},
--            --cppcheck-build-dir=path
            extra_args = { "--enable=warning,style,performance,portability,information,unusedFunction,missingInclude", "--std=c11", "--platform=unix64", "$FILENAME" },
        }),
        require("null-ls").builtins.formatting.black.with({
            filetypes = { "python" },
            extra_args = { "--fast"},
        }),
        require("null-ls").builtins.formatting.remark.with({
            filetypes = { "markdown" },
            extra_args = { "$FILENAME" },
        }),
        require("null-ls").builtins.formatting.prettierd.with({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css", "scss", "less", "html", "json", "jsonc", "yaml", "markdown", "graphql", "handlebars" },
            extra_args = { "$FILENAME" },
        }),
        require("null-ls").builtins.formatting.stylua.with({
            filetypes = { "lua" },
            extra_args = { "$FILENAME" },
        })
    },
})

