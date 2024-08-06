return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "j-hui/fidget.nvim",
    },
    config = function()
      local util = require 'lspconfig.util'

      local cmp = require('cmp')
      local cmp_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities())

      require("fidget").setup({})
      require("mason").setup()
      require("mason-lspconfig").setup({
        handlers = {
          ["tsserver"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.tsserver.setup({
              capabilities = capabilities,
            })
          end,

          ["eslint"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.eslint.setup({
              capabilities = capabilities,
              filetypes = {
                'javascript',
                'javascriptreact',
                'json',
                'jsonc',
                'typescript',
                'typescript.tsx',
                'typescriptreact',
                'astro',
                'svelte',
                'vue',
                'css',
              },
              root_dir = util.root_pattern(
                '.eslintrc',
                '.eslintrc.js',
                '.eslintrc.cjs',
                '.eslintrc.yaml',
                '.eslintrc.yml',
                '.eslintrc.json',
                'eslint.config.js',
                'eslint.config.mjs',
                'eslint.config.cjs',
                'eslint.config.ts',
                'eslint.config.mts',
                'eslint.config.cts'
              ),
            })
          end,
          ["biome"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.biome.setup({
              capabilities = capabilities,
              filetypes = {
                'javascript',
                'javascriptreact',
                'json',
                'jsonc',
                'typescript',
                'typescript.tsx',
                'typescriptreact',
                'astro',
                'svelte',
                'vue',
                'css',
              },
              root_dir = util.root_pattern('biome.json', 'biome.jsonc')

            })
          end,
          ["lua_ls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup {
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = { version = "Lua 5.1" },
                  diagnostics = {
                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                  }
                }
              }
            }
          end,
        }
      })
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
        }, {
          { name = 'buffer' },
        })
      })

      vim.diagnostic.config({
        -- update_in_insert = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    optional = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.prettier)
      table.insert(opts.sources, nls.builtins.diagnostics.eslint)
      table.insert(opts.sources, nls.builtins.code_actions.eslint)
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    dependencies = { "jose-elias-alvarez/null-ls.nvim" },
    opts = function(_, opts)
      require("mason-null-ls").setup({
        ensure_installed = { "prettier", "eslint" },
        automatic_installation = true,
        handlers = {},
      })
    end,
  }
}
