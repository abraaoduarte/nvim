local defaults = { noremap = true, silent = true }
local mapping = {}

mapping.map = function(type, shortcut, command, config)
	config = config or defaults
	vim.api.nvim_set_keymap(type, shortcut, command, config)
end

mapping.normal_map = function(shortcut, command, config)
	config = config or defaults
	vim.api.nvim_set_keymap('n', shortcut, command, config)
end

return mapping
