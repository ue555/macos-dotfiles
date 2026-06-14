vim.g.mapleader = " "

vim.opt.number = true

local current_listchars = vim.opt.listchars:get()
current_listchars.space = "."
current_listchars.tab = ">."
vim.opt.listchars = current_listchars

vim.opt.list = true

vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.softtabstop = 4
		vim.bo.expandtab = false
	end,
})

require("core/lazyvim")
require("core/keymaps")
