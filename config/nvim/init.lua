require("config.lazy")
require('config.keybinds')
require('config.options')
local todofloat = require('todofloat')
todofloat.setup({
	targetfile = "~/school/fall_2025/cs1410/minesweeper/todo.md"
})
