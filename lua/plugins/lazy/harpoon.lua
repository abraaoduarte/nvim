return {
  "ThePrimeagen/harpoon",
  config = function()
    local harpoon = require("harpoon")
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    harpoon.setup({}) -- Default setup

    local keymap = vim.keymap.set

    keymap("n", "<leader>a", function() mark.add_file() end, { desc = "Add file to Harpoon" })
    keymap("n", "<C-e>", function() ui.toggle_quick_menu() end, { desc = "Toggle Harpoon Menu" })

    -- Navigation between files
    keymap("n", "<C-h>", function() ui.nav_file(1) end, { desc = "Harpoon to file 1" })
    keymap("n", "<C-j>", function() ui.nav_file(2) end, { desc = "Harpoon to file 2" })
    keymap("n", "<C-k>", function() ui.nav_file(3) end, { desc = "Harpoon to file 3" })
    keymap("n", "<C-l>", function() ui.nav_file(4) end, { desc = "Harpoon to file 4" })
  end
}

