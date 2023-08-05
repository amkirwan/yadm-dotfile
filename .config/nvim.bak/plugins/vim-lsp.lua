local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.buf.inlay_hint(bufnr, true)
  end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

  -- You can delete this if you enable format-on-save.
  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
end

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

capabilities.textDocument.completion.completionItem.snippetSupport = true

-- typscript server --
lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- gopls server --
lspconfig.gopls.setup({
  cmd = { "gopls", "-remote=auto" },
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    -- Don't spam LSP with changes. Wait a second between each.
    debounce_text_changes = 1000,
  },
  -- settings = {
  --   gopls = {
  --     gofumpt = true,
  --   },
  -- },
  init_options = {
    staticcheck = true,
    -- gofumpt = true,
    memoryMode = "DegradeClosed",
  },
})

-- html server --
lspconfig.html.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- lua
lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

lspconfig.yamlls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    yaml = {
      schemaStore = {
        url = "https://www.schemastore.org/api/json/catalog.json",
        enable = true,
      },
    },
  },
})

lspconfig.eslint.setup({
  capabilities = capabilities,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
    "svelte",
    "astro",
  },
  diagnostics = {
    enable = true,
    report_unused_disable_directives = false,
    run_on = "save", -- or `save`
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.buf.inlay_hint(bufnr, true)
    end
  end,
})

-- for _, server in ipairs(All_Servers) do
--   lspconfig[server].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
--   })
-- end

local patterns = {
  "*.lua",
  "*.tsx",
  "*.jsx",
  "*.ts",
  "*.js",
  "*.css",
  "*.html",
  "*.yaml",
  "*.rb",
  "*.java",
  "*.rs",
  "*.json",
  "*.sql",
}

vim.api.nvim_create_augroup("AutoFormatting", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = patterns,
  group = "AutoFormatting",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- With LSP, "reformat my source code" and "organize my imports" are separate operations.
-- This is a hook to do this automatically on save --
local function goFormatAndImports(wait_ms)
  -- Prefer `format` if available because `formatting_sync` has been deprecated as of nvim v0.8.0.
  if vim.lsp.buf.format == nil then
    vim.lsp.buf.formatting_sync(nil, wait_ms)
  else
    vim.lsp.buf.format({
      timeout_ms = wait_ms,
    })
  end
  vim.lsp.buf.format({
    timeout_ms = wait_ms,
  })
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
  callback = function()
    goFormatAndImports(3000)
  end,
})
