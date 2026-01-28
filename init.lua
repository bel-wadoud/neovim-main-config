vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 4

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- load plugins
require("lazy").setup("plugins")

vim.cmd('colorscheme habamax')
vim.cmd('set number')

require("lsp")

-- auto format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    vim.lsp.buf.format({
      bufnr = args.buf,
      timeout_ms = 2000,
    })
  end,
})


-- shifting numbers and symbols
local nums = {'1','2','3','4','5','6','7','8','9','0'}
local specials = {'!','@','#','$','%','^','&','*','(',')'}

for i = 1, #nums do
  vim.keymap.set('i', nums[i], specials[i], opts)
  vim.keymap.set('i', specials[i], nums[i], opts)
end

-- escaping without using the real escape
vim.keymap.set("i", "kj", "<Esc>", {
  noremap = true,
  silent = true,
})
