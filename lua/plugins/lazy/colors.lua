function ColorMyPencils(color)
    color = color or "catppuccin"
    vim.cmd.colorscheme(color)

    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                theme = 'storm',
                transparent = true,
                terminal_colors = true,
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = false },
                    keywords = { italic = false },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "dark",   -- style for floating windows
                },
            })
        end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin")
            ColorMyPencils()
        end,
    },
    --    {
    --        "rose-pine/neovim",
    --        name = "rose-pine",
    --        config = function()
    --            require('rose-pine').setup({
    --                disable_background = true,
    --                styles = {
    --                    italic = false,
    --                },
    --            })
    --
    --            vim.cmd("colorscheme rose-pine")
    --
    --            ColorMyPencils()
    --        end
    --    },
    {
        "nvim-lualine/lualine.nvim",
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "dracula",
                },
            })
        end,
    },
}
