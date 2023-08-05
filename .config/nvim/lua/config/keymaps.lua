-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- bufferline
vim.keymap.set("n", "<leader>bL", ":BufferLineCycleNext<CR>", { desc = "Nav to next buffer" })
vim.keymap.set("n", "<leader>bH", ":BufferLineCyclePrev<CR>", { desc = "Nav to prev buffer" })
vim.keymap.set("n", "<leader>bm", ":BufferLineMoveNext<CR>", { desc = "Move buffer forward" })
vim.keymap.set("n", "<leader>bM", ":BufferLineMovePrev<CR>", { desc = "Move buffer backward" })
vim.keymap.set(
  "n",
  "<leader>bf",
  ":lua require('bufferline').move_to(1)<CR>",
  { desc = "Move buffer to first position" }
)
vim.keymap.set(
  "n",
  "<leader>bl",
  ":lua require('bufferline').move_to(-1)<CR>",
  { desc = "Move buffer to last position" }
)
vim.keymap.set("n", "<leader>gp", ":BufferLinePick<CR>", { desc = "Pick buffer by char" })
vim.keymap.set("n", "<leader>gc", ":BufferLinePickClose<CR>", { desc = "Close buffer by char " })

vim.keymap.set("n", "<silent>ge", ":BufferLineSortByExtension<CR>", { desc = "Sort buffers by extension" })
vim.keymap.set("n", "<silent>gd", ":BufferLineSortByDirectory<CR>", { desc = "Sort buffers by dir" })

vim.keymap.set("n", "<leader>1", '<cmd>lua require("bufferline").go_to(1, true)<cr>')
vim.keymap.set("n", "<leader>2", '<cmd>lua require("bufferline").go_to(2, true)<cr>')
vim.keymap.set("n", "<leader>3", '<cmd>lua require("bufferline").go_to(3, true)<cr>')
vim.keymap.set("n", "<leader>4", '<cmd>lua require("bufferline").go_to(4, true)<cr>')
vim.keymap.set("n", "<leader>5", '<cmd>lua require("bufferline").go_to(5, true)<cr>')
vim.keymap.set("n", "<leader>6", '<cmd>lua require("bufferline").go_to(6, true)<cr>')
vim.keymap.set("n", "<leader>7", '<cmd>lua require("bufferline").go_to(7, true)<cr>')
vim.keymap.set("n", "<leader>8", '<cmd>lua require("bufferline").go_to(8, true)<cr>')
vim.keymap.set("n", "<leader>9", '<cmd>lua require("bufferline").go_to(9, true)<cr>')

-- lsp diagnostic to show in popup when text is too long
vim.keymap.set(
  "n",
  "<leader>do",
  vim.diagnostic.open_float,
  { desc = "lsp diagnostic popup", noremap = true, silent = true }
)

-- Spectre
vim.keymap.set("n", "<leader>spw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "Search current word (Spectre)",
})
vim.keymap.set("n", "<leader>spp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file (Spectre)",
})
