-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function get_offset_encoding()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  for _, client in ipairs(clients) do
    if client and client.offset_encoding then
      return client.offset_encoding
    end
  end
  return "utf-8" -- fallback
end

function GoFormatAndImports(wait_ms)
  local encoding = get_offset_encoding()
  local params = vim.lsp.util.make_range_params(nil, encoding)
  ---@diagnostic disable-next-line: inject-field
  params.context = { only = { "source.organizeImports" } }

  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      local ok, err = pcall(vim.lsp.util.apply_workspace_edit, r.edit, encoding)
      if not ok then
        vim.notify("Workspace edit failed: " .. tostring(err), vim.log.levels.ERROR)
      end
    end
  end

  if vim.lsp.buf.format then
    vim.lsp.buf.format({ timeout_ms = wait_ms })
  else
    vim.lsp.buf.formatting_sync(nil, wait_ms)
  end
end

vim.api.nvim_create_augroup("GoAutoFormat", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = "GoAutoFormat",
  pattern = "*.go",
  callback = function()
    GoFormatAndImports(3000)
  end,
})
