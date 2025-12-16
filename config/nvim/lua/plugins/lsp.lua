return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			'saghen/blink.cmp',
			{
				"folke/lazydev.nvim",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			local capabilities = require('blink.cmp').get_lsp_capabilities()
			vim.lsp.enable('lua_ls')
			vim.lsp.config('lua_ls', {
				capabilities = capabilities
			})
			vim.lsp.enable('pyright')
			vim.lsp.config('pyright', {
				capabilities = capabilities
			})
			vim.lsp.enable('ols')
			vim.lsp.config('ols', {
				capabilities = capabilities
			})
			vim.lsp.enable('nil_ls')
			vim.lsp.config('nil_ls', {
				capabilities = capabilities
			})
			vim.lsp.enable('gopls')
			vim.lsp.config('gopls', {
				capabilities = capabilities
			})

			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(args)
					local c = vim.lsp.get_client_by_id(args.data.client_id)
					if not c then return end

					if vim.bo.filetype == "lua" or "odin" or "python" or "go" then
						-- Format the current buffer on save
						vim.api.nvim_create_autocmd('BufWritePre', {
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
							end,
						})
					end
				end,
			})
		end,
	}
}
