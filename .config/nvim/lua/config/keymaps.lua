-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

vim.keymap.set("n", "<leader>cp", ':let @*=expand("%")<CR>', { desc = "copy relative path to clipboard" })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

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
vim.keymap.set("n", "<leader>bc", ":BufferLinePick<CR>", { desc = "Pick buffer by char" })
vim.keymap.set("n", "<leader>bC", ":BufferLinePickClose<CR>", { desc = "Close buffer by char " })

vim.keymap.set("n", "<leader>bse", ":BufferLineSortByExtension<CR>", { desc = "Sort buffers by extension" })
vim.keymap.set("n", "<leader>bsd", ":BufferLineSortByDirectory<CR>", { desc = "Sort buffers by dir" })

-- vim.keymap.set("n", "<leader>1", '<cmd>lua require("bufferline").go_to(1, true)<cr>', { desc = "Buffer 1" })
-- vim.keymap.set("n", "<leader>2", '<cmd>lua require("bufferline").go_to(2, true)<cr>', { desc = "Buffer 2" })
-- vim.keymap.set("n", "<leader>3", '<cmd>lua require("bufferline").go_to(3, true)<cr>', { desc = "Buffer 3" })
-- vim.keymap.set("n", "<leader>4", '<cmd>lua require("bufferline").go_to(4, true)<cr>', { desc = "Buffer 4" })
-- vim.keymap.set("n", "<leader>5", '<cmd>lua require("bufferline").go_to(5, true)<cr>', { desc = "Buffer 5" })
-- vim.keymap.set("n", "<leader>6", '<cmd>lua require("bufferline").go_to(6, true)<cr>', { desc = "Buffer 6" })
-- vim.keymap.set("n", "<leader>7", '<cmd>lua require("bufferline").go_to(7, true)<cr>', { desc = "Buffer 7" })
-- vim.keymap.set("n", "<leader>8", '<cmd>lua require("bufferline").go_to(8, true)<cr>', { desc = "Buffer 8" })
-- vim.keymap.set("n", "<leader>9", '<cmd>lua require("bufferline").go_to(9, true)<cr>', { desc = "Buffer 9" })

-- lsp diagnostic to show in popup when text is too long
vim.keymap.set(
  "n",
  "<leader>do",
  vim.diagnostic.open_float,
  { desc = "lsp diagnostic popup", noremap = true, silent = true }
)

vim.keymap.set("i", "<Tab>", function()
  local copilot = require("copilot.suggestion")
  if copilot.is_visible() then
    copilot.accept()
  else
    local cmp = require("cmp")
    if cmp.visible() then
      cmp.select_next_item()
    else
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)
    end
  end
end, { desc = "Copilot Accept or Next Completion", silent = true })

local function open_grug_in_file(search_term)
  local grug = require("grug-far")
  local buffer = vim.fn.expand("%")
  grug.open({
    transient = true,
    prefills = {
      find = search_term,
      paths = buffer,
    },
  })
end

-- Normal mode: open grug with current file path
vim.keymap.set("n", "<leader>sf", function()
  open_grug_in_file("")
end, { desc = "Search and Replace in current file", silent = true })

-- Visual mode: open grug with selected text as search term
vim.keymap.set("v", "<leader>sf", function()
  -- Get the selected text
  local _, ls, cs = unpack(vim.fn.getpos("'<"))
  local _, le, ce = unpack(vim.fn.getpos("'>"))
  local lines = vim.fn.getline(ls, le)

  if #lines == 0 then
    return
  end

  -- Trim to selected range
  lines[#lines] = string.sub(lines[#lines], 1, ce)
  lines[1] = string.sub(lines[1], cs)

  local selection = table.concat(lines, "\n")
  open_grug_in_file(selection)
end, { desc = "Search and Replace with selection", silent = true })

-- vim.keymap.set(
--   "n",
--   "<leader>sl",
--   require("telescope").extensions.live_grep_args,
--   { desc = "live args", noremap = true }
-- )
