local home = os.getenv("HOME")

-- helper function to control formatting per server
local function format_on_attach(client)
  if client.name == "eslint" then
    client.server_capabilities.documentFormattingProvider = true
  elseif client.name == "tsserver" or client.name == "vtsls" then
    client.server_capabilities.documentFormattingProvider = false
  end
end

return {
  "neovim/nvim-lspconfig",
  opts = {
    codelens = {
      enable = true,
      icons = { enabled = true, disabled = true },
    },
    servers = {
      eslint = {
        on_attach = format_on_attach,
        settings = {
          nodePath = home .. "/web-code/.yarn/sdks",
          workingDirectory = { mode = "auto" },
        },
      },
      tsserver = {
        on_attach = format_on_attach,
      },
      vtsls = {
        on_attach = format_on_attach,
        settings = {
          typescript = {
            preferences = { includePackageJsonAutoImports = "off" },
            tsserver = { maxTsServerMemory = 8192 },
            tsdk = home .. "/web-code/.yarn/sdks/typescript/lib",
          },
        },
      },
      gopls = {
        keys = {
          -- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
          { "<leader>td", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug Nearest (Go)" },
        },
        cmd = {
          "gopls",
          "-remote=auto",
          "-rpc.trace",
          "-v",
        },
        init_options = {
          gofumpt = true,
          memoryMode = "DegradeClosed",
          staticcheck = true,
        },
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            semanticTokens = true,
          },
        },
      },
      ulsp = {},
    },
    setup = {
      -- ulsp is still a custom server
      ulsp = function(_, opts)
        local lspconfig = require("lspconfig")
        local configs = require("lspconfig.configs")

        if not configs.ulsp then
          configs.ulsp = {
            default_config = {
              cmd = { "socat", "-", "tcp:localhost:27883,ignoreeof" },
              flags = { debounce_text_changes = 1000 },
              capabilities = opts.capabilities,
              filetypes = { "go", "java" },
              root_dir = function(fname)
                local result = require("lspconfig.async").run_command({ "git", "rev-parse", "--show-toplevel" })
                if result and result[1] then
                  return vim.trim(result[1])
                end
                return require("lspconfig.util").root_pattern(".git")(fname)
              end,
              single_file_support = false,
            },
            docs = { description = "Custom uLSP integration" },
          }
        end

        lspconfig.ulsp.setup({
          capabilities = opts.capabilities,
          on_attach = opts.on_attach,
        })
        return true
      end,
    },
  },
}
