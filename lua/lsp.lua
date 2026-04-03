local lsp = vim.lsp

local on_attach = function(_, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
      buffer = bufnr,
      silent = true,
      desc = desc,
    })
  end

  -- Navigation
  map("n", "gd", lsp.buf.definition, "Go to definition")
  map("n", "gD", lsp.buf.declaration, "Go to declaration")
  map("n", "gi", lsp.buf.implementation, "Go to implementation")
  map("n", "gr", lsp.buf.references, "References")
  map("n", "gt", lsp.buf.type_definition, "Type definition")

  -- Info
  map("n", "K", lsp.buf.hover, "Hover documentation")
  map("n", "<C-k>", lsp.buf.signature_help, "Signature help")

  -- Actions
  map("n", "<leader>rn", lsp.buf.rename, "Rename symbol")
  map({ "n", "v" }, "<leader>ca", lsp.buf.code_action, "Code action")

  -- Diagnostics
  map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
  map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
  map("n", "<leader>e", vim.diagnostic.open_float, "Diagnostic float")
  map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostics list")

  -- Formatting
  map("n", "<leader>f", function()
    lsp.buf.format({ async = true })
  end, "Format buffer")
end
