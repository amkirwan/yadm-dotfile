-- telescope config --
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>*', builtin.grep_string, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- To get fzf loaded and working with telescope, you need to call
require('telescope').load_extension('fzf')

require("telescope").load_extension('zoxide')

require("telescope").load_extension('neoclip')

require('telescope').load_extension('vim_bookmarks')

