return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "neovim/nvim-lspconfig" },
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function()
				local set = vim.keymap.set
				set("n", "gD", vim.lsp.buf.declaration, { buffer = true })
				set("n", "gd", vim.lsp.buf.definition, { buffer = true })
				set("n", "K", vim.lsp.buf.hover, { buffer = true })
				set("n", "gi", vim.lsp.buf.implementation, { buffer = true })
				set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = true })
				set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { buffer = true })
				set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { buffer = true })
				set(
					"n",
					"<space>wl",
					function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end,
					{ buffer = true }
				)
				set("n", "<space>D", vim.lsp.buf.type_definition, { buffer = true })
				set("n", "<space>rn", vim.lsp.buf.rename, { buffer = true })
				set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = true })
				set("n", "gr", vim.lsp.buf.references, { buffer = true })
				set("n", "<space>e", vim.diagnostic.open_float, { buffer = true })
				set("n", "[d", vim.diagnostic.goto_prev, { buffer = true })
				set("n", "]d", vim.diagnostic.goto_next, { buffer = true })
				set("n", "<space>q", vim.diagnostic.setloclist, { buffer = true })
				set("n", "<space>f", vim.lsp.buf.format, { buffer = true })
			end,
		})
		
		require("mason").setup()
		vim.lsp.config("*", {
			capabilities = capabilities,
		})
		require("mason-lspconfig").setup({
			ensure_installed = { "gopls", "lua_ls", "rust_analyzer", "intelephense", "ts_ls", "pyright" },
			handlers = {
				function(server_name)
					vim.lsp.enable(server_name)
				end,
				["lua_ls"] = function()
					vim.lsp.config("lua_ls", {
						settings = {
							Lua = {
								completion = {
									callSnippet = "Replace",
								},
							},
						},
					})
					vim.lsp.enable("lua_ls")
				end,
			},
		})
		
		-- Marksman (installed via Nix, not Mason)
		vim.lsp.config("marksman", {
			cmd = { "marksman", "server" },
			filetypes = { "markdown", "markdown.mdx" },
			root_markers = { ".git", ".marksman.toml" },
		})
		vim.lsp.enable("marksman")
	end,
}
