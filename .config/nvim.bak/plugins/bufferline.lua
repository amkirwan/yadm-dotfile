require("bufferline").setup({
  options = {
    numbers = "ordinal",
    show_buffer_icons = true,
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    separator_style = "tp",
    indicator = {
      style = 'underline',
    },
    diagnostics = "nvim_lsp",
    color_icons = true, -- whether or not to add the filetype icon highlights
    offsets = {
      {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true
        }
      },
  },
})

vim.keymap.set('n', 'bn', ':BufferLineCycleNext<CR>')
vim.keymap.set('n', 'bp', ':BufferLineCyclePrev<CR>')
vim.keymap.set('n', 'bm', ':BufferLineMoveNext<CR>')
vim.keymap.set('n', 'bM', ':BufferLineMovePrev<CR>')
vim.keymap.set('n', 'bf', ":lua require('bufferline').move_to(1)<CR>")
vim.keymap.set('n', 'bl', ":lua require('bufferline').move_to(-1)<CR>")
vim.keymap.set('n', '<leader>bp', ":BufferLinePick<CR>")
vim.keymap.set('n', '<leader>bc', ":BufferLinePickClose<CR>")

