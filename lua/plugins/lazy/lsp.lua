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
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "gopls",
                },
                handlers = {
                    function(server_name) -- default handler (optional)
                        require("lspconfig")[server_name].setup {
                            capabilities = capabilities
                        }
                    end,

                    ["gopls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.gopls.setup({
                            capabilities = capabilities
                        })
                    end,

                    ["tsserver"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.tsserver.setup({
                            capabilities = capabilities
                        })
                    end,

                    ["eslint"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.eslint.setup({
                            settings = {
                                useFlatConfig = true,
                                experimental = {
                                    useFlatConfig = nil, -- option not in the latest eslint-lsp
                                },
                            },
                            capabilities = capabilities
                        })
                    end,

                    ["tailwindcss"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.tailwindcss.setup({
                            capabilities = capabilities,
                            filetypes = { "templ", "javascript", "typescript", "react" },
                        })
                    end,

                    ["html"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.html.setup({
                            capabilities = capabilities,
                            filetypes = { "html", "templ" },
                        })
                    end,

                    ["templ"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.html.setup({
                            capabilities = capabilities,
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
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
        },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    -- require("none-ls.diagnostics.eslint_d"),
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.goimports,
                    null_ls.builtins.formatting.gofumpt,
                    --  null_ls.builtins.completion.spell,
                },
            })
            vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
        end,
    },
}
