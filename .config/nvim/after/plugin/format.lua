require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.astyle.with({
            filetypes = { "c", "cpp" },
            extra_args = { "--options=${DOTCONF}/.astylerc", "--project=none" }
        }),
        require("null-ls").builtins.formatting.black.with({
            filetypes = { "py" },
        }),
        require("null-ls").builtins.formatting.remark.with({
            filetypes = { "md" },
--            extra_args = {},
        }),
--        require("null-ls").builtins.diagnostics.eslint,
--        require("null-ls").builtins.completion.spell,
--        null_ls.builtins.code_actions.gitsigns,
    },
})

