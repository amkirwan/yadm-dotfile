-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- With LSP, "reformat my source code" and "organize my imports" are separate operations.
-- This is a hook to do this automatically on save --
function GoFormatAndImports(wait_ms)
  -- Prefer `format` if available because `formatting_sync` has been deprecated as of nvim v0.8.0.
  if vim.lsp.buf.format == nil then
    vim.lsp.buf.formatting_sync(nil, wait_ms)
  else
    vim.lsp.buf.format({
      timeout_ms = wait_ms,
    })
  end
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function(args)
    GoFormatAndImports(3000)
  end,
})
