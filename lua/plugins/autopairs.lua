return {
  "windwp/nvim-autopairs",
  config = function()
    require("nvim-autopairs").setup({
      disable_filetype = { "TelescopePrompt", "vim" },
      check_ts = true,   -- use treesitter for smarter pairing
      fast_wrap = {},
    })

    -- attach to cmp so <CR> doesn't break pair insert
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}

