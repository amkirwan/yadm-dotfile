  -- trouble setup
  --
 -- Don't use virtual text to display diagnostics.
  -- Signs in the gutter + trouble is enough.
  vim.diagnostic.config({
      virtual_text = false,
  })

  require("trouble").setup()

  vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
  )
  vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
    {silent = true, noremap = true}
  )
  vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
    {silent = true, noremap = true}
  )
  vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
    {silent = true, noremap = true}
  )
  vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
    {silent = true, noremap = true}
  )
  vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
    {silent = true, noremap = true}
)


