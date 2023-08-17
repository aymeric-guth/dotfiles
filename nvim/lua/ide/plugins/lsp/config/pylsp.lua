return {
  settings = {
    pylsp = {
      trace = { server = 'verbose' },
      configurationSources = { 'flake8' },
      plugins = {
        flake8 = { enabled = true },
        pylint = { enabled = false },
        pycodestyle = { enabled = false },
        pyflakes = { enabled = false },
        jedi = { enabled = true },
        jedi_completion = { enabled = true },
        jedi_definition = { enabled = true },
        jedi_hover = { enabled = true },
        mccabe = { enabled = true },
        preload = { enabled = false },
        pydocstyle = { enabled = false },
        rope_completion = { enabled = false },
        yapf = { enabled = false },
        rope = { enabled = false },
        -- 3rd parties
        pylsp_mypy = { enabled = false },
        pylsp_black = { enabled = false },
        pylsp_isort = { enabled = false },
        -- deprecated api call
        pylsp_memestra = { enabled = false },
      },
      --			plugins = {
      --				flake8 = {
      --					config = "",
      --					enabled = false,
      --					exclude = {},
      --					executable = "",
      --					filename = "",
      --					hangClosing = false,
      --					ignore = {},
      --					maxLineLength = 0,
      --					perFileIgnores = {},
      --					select = {},
      --				},
      --				jedi = {
      --					extra_paths = {},
      --					env_vars = {},
      --					environment = "",
      --				},
      --				jedi_completion = {
      --					enabled = true,
      --					include_params = true,
      --					include_class_objects = true,
      --					fuzzy = true,
      --					eager = false,
      --					resolve_at_most_labels = 25,
      --					cache_labels_for = { "actors" },
      --				},
      --				jedi_definition = {
      --					enabled = true,
      --					follow_imports = true,
      --					follow_builtin_imports = true,
      --				},
      --				jedi_hover = { enabled = true },
      --				jedi_references = { enabled = true },
      --				jedi_signature_help = { enabled = true },
      --				jedi_symbols = {
      --					enabled = true,
      --					all_scopes = false,
      --					include_import_symbols = true,
      --				},
      --				mccabe = {
      --					enabled = false,
      --					threshold = 15,
      --				},
      --				preload = {
      --					enabled = false,
      --					modules = {},
      --				},
      --				pycodestyle = {
      --					enabled = false,
      --					exclude = {},
      --					filename = {},
      --					select = {},
      --					ignore = {},
      --					hangClosing = false,
      --					maxLineLength = 0,
      --				},
      --				pydocstyle = {
      --					enabled = false,
      --					convention = "",
      --					addIgnore = {},
      --					addSelect = {},
      --					ignore = {},
      --					select = {},
      --					match = "",
      --					matchDir = "",
      --				},
      --				pyflakes = { enabled = false },
      --				pylint = {
      --					enabled = false,
      --					args = {},
      --					executable = "",
      --				},
      --				rope_completion = {
      --					enabled = false,
      --					eager = false,
      --				},
      --				yapf = {
      --					enabled = false,
      --				},
      --				rope = {
      --					extensionModules = "",
      --					ropeFolder = {},
      --				},
      --				mypy = { enabled = false },
      --			},
    },
  },
}
