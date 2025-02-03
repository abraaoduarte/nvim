return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require('gitsigns').setup({

      on_attach = function()
        local gitsigns = require('gitsigns')
        vim.keymap.set('n', '<leader>hb', function() gitsigns.blame_line { full = true } end)
        vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame)
        vim.keymap.set('n', '<leader>hd', gitsigns.diffthis)
        vim.keymap.set('n', '<leader>hD', function() gitsigns.diffthis('~') end)
        vim.keymap.set('n', '<leader>td', gitsigns.toggle_deleted)
      end,
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    })
  end
}
