return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<leader>c", ":bd<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<leader>x", ":BufferLinePickClose<CR>", { noremap = true, silent = true }),

  config = function()
    require("bufferline").setup({
      options = {
        diagnostics = "nvim_lsp",       -- Exibe ícones de erro (se usar LSP)
        show_close_icon = false,        -- Esconde o ícone de fechar global
        show_buffer_close_icons = true, -- Mantém os ícones de fechar nos buffers
        separator_style = "slant",      -- Estilo dos separadores (slant, thick, thin)
        --  always_show_bufferline = true,  -- Mostra sempre a bufferline
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    })
  end
}
