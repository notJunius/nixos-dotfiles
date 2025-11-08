vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("n", "<space>w", "<cmd>w<CR>")
vim.keymap.set("n", "<space>q", "<cmd>q!<CR>")
vim.keymap.set("n", "<space>t", "<cmd>Td<CR>")
--vim.keymap.set("n", "<space>de", ":lua vim.diagnostic.enable()<CR>")
--vim.keymap.set("n", "<space>dd", ":lua vim.diagnostic.disable()<CR>")
vim.keymap.set("n", "-", "<cmd>Oil<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

-- change for current python file
vim.keymap.set("n", "<space>p", "<cmd>!python3 main.py<CR>")
