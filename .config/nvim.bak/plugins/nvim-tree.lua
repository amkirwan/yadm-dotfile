-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.keymap.set('n', '-', ":NvimTreeToggle<CR>", opts)
vim.keymap.set('n', '<leader>-', ":NvimTreeFindFileToggle<CR>", opts)

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = false,
    },
    view = {
      side = 'right',
      width = 60,
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      severity = {
        min = vim.diagnostic.severity.ERROR,
        max = vim.diagnostic.severity.ERROR,
      }
    },
})
