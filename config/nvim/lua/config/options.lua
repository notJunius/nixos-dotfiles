local set = vim.opt
set.shiftwidth = 2
set.tabstop = 2
set.clipboard = "unnamedplus"
set.number = true
set.relativenumber = true
set.pumheight = 10
set.cursorline = true
set.colorcolumn = "80"
set.scrolloff = 10
set.updatetime = 50
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gD", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
set.wrap = false


-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
