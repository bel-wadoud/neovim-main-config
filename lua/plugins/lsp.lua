return {
  -- Mason: installs tools
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({ ui = { border = "rounded" } })
    end,
  },

  -- Mason + LSP
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      mason_lspconfig.setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "ts_ls",
          "bashls",
          "html",
          "cssls",
          "jsonls",
          "clangd",
          "rust_analyzer",
          "dockerls",
          "yamlls",
          "docker_compose_language_service",
          "marksman",
          "taplo",
        },
        automatic_installation = true,
      })

      -- Manual setup for each server
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      lspconfig.clangd.setup({
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--header-insertion=iwyu",
          "--function-arg-placeholders",
        },
      })

      lspconfig.pyright.setup({ capabilities = capabilities })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        settings = { completions = { completeFunctionCalls = true } },
      })

      lspconfig.dockerls.setup({
        capabilities = capabilities,
      })
      lspconfig.docker_compose_language_service.setup({
        capabilities = capabilities,
      })
      lspconfig.yamlls.setup({
        capabilities = capabilities,
        settings = {
          yaml = {
            keyOrdering = false,
          },
        },
      })

      lspconfig.taplo.setup({ capabilities = capabilities })
      lspconfig.marksman.setup({ capabilities = capabilities })


      lspconfig.bashls.setup({ capabilities = capabilities })
      lspconfig.html.setup({ capabilities = capabilities })
      lspconfig.cssls.setup({ capabilities = capabilities })
      lspconfig.jsonls.setup({
        capabilities = capabilities,
        settings = { json = { validate = { enable = true } } },
      })
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
            },
            checkOnSave = true,
            check = {
              command = "clippy",
            },

            inlayHints = {
              bindingModeHints = { enable = true },
              chainingHints = { enable = true },
              closingBraceHints = { enable = true },
              closureReturnTypeHints = { enable = "with_block" },
              lifetimeElisionHints = { enable = "always" },
              parameterHints = { enable = true },
              reborrowHints = { enable = true },
              typeHints = { enable = true },
            },
          },
        },
      })
    end,
  },
}
