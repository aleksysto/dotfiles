return {
	"VonHeikemen/lsp-zero.nvim",
	event = { "BufReadPre", "BufNewFile" },
	name = "lsp-zero",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup({
			ui = {
				border = "rounded",
			},
		})
		require("mason-lspconfig").setup()
		-- Optional: Only required if you need to update the language server settings
		vim.lsp.config.pyright = {
			settings = {
				python = {
					analysis = {
						diagnosticMode = "workspace",
						autoImportCompletion = true,
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						extraPaths = { "src" },
					},
				},
			},
			flags = {
				debounce_text_changes = 100,
			},
		}
		-- vim.lsp.config("ty", {
		-- 	settings = {
		-- 		ty = {
		-- 			diagnosticMode = "workspace",
		-- 			configuration = {
		-- 				-- environment = {
		-- 				-- 	python = "./.venv",
		-- 				-- 	root = { "./src", "./" },
		-- 				-- },
		-- 				rules = {

		-- 					["possibly-unresolved-reference"] = "warn",
		-- 					["possibly-missing-import"] = "warn",
		-- 				},
		-- 			},
		-- 		},
		-- 	},
		-- })

		-- Required: Enable the language server
		-- vim.lsp.enable("ty")

		vim.lsp.config("clangd", {
			-- Server-specific settings. See `:help lsp-quickstart`
			settings = {
				["clangd"] = {
					capabilities = {
						{
							offsetEncoding = { "utf-8", "utf-16" },
							textDocument = {
								completion = {
									editsNearCursor = true,
								},
							},
						},
					},
					cmd = { "clangd" },
					filetype = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
					root_markers = {
						".clangd",
						".clang-tidy",
						".clang-format",
						"compile_commands.json",
						"compile_flags.txt",
						"configure.ac",
						".git",
					},
				},
			},
		})
	end,
}
-- vim.lsp.config.ruff = {
--   on_attach = function(client, _)
--     -- Ruff should NOT be asked for “language intelligence”
--     client.server_capabilities.hoverProvider = false
--     client.server_capabilities.definitionProvider = false
--     client.server_capabilities.referencesProvider = false
--     client.server_capabilities.renameProvider = false
--     client.server_capabilities.completionProvider = nil
--     client.server_capabilities.signatureHelpProvider = nil
--   end,
-- }
--
-- vim.lsp.enable({ "ruff", "pyrefly" })
