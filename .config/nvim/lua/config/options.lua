-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.lsp.set_log_level("ERROR")

vim.g.copilot_assume_mapped = true

vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_conceal = 0

vim.opt.spelllang = "en_us"
vim.opt.spell = true

vim.g.lazyvim_picker = "snacks"
