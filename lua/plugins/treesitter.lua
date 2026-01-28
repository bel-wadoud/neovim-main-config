-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup {
      ensure_installed = {'c', 'lua', 'rust', 'vim', 'html', 'css', 'python', 'C++', 'bash'},
      sync_install = false,
      auto_install = true,
      highlight = { enable = true },
    };
  end,
}
