vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.number = true
vim.opt.relativenumber = true


-- Completely silence LSP deprecation warnings and other annoying notifications
vim.notify = function(msg, log_level, opts)
  -- Only show real errors, hide warnings and info messages
  if log_level == vim.log.levels.ERROR then
    vim.api.nvim_echo({ { msg, "ErrorMsg" } }, true, {})
  end
end

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

vim.keymap.set("n", "<leader>th", function()
  vim.lsp.inlay_hint.enable(
    not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }),
    { bufnr = 0 }
  )
end)

vim.diagnostic.config({
  virtual_text = false, -- no inline error text
  signs = true,         -- keep gutter icons
  underline = true,     -- keep red underline
  update_in_insert = false,
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      border = "rounded",
    })
  end
})

vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

vim.api.nvim_set_hl(0, "LspInlayHint", {
  fg = "#6c7086",
  italic = true,
})



-- auto format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    vim.lsp.buf.format({
      bufnr = args.buf,
      timeout_ms = 2000,
    })
  end,
})

-- escaping without using the real escape
vim.keymap.set("i", "kj", "<Esc>", {
  noremap = true,
  silent = true,
})


vim.cmd("colorscheme tokyonight")

vim.keymap.set("n", "<S-l>", ":bnext<CR>")
vim.keymap.set("n", "<S-h>", ":bprev<CR>")

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>r", ":NvimTreeRefresh<CR>")
vim.keymap.set("n", "<leader>n", ":NvimTreeFindFile<CR>")
