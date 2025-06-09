return {
  "neovim/nvim-lspconfig",
  opts = {
    codelens = {
      enable = true,
      icons = {
        enabled = true,
        disabled = true,
      },
    },
    servers = {
      eslint = {
        settings = {
          nodePath = "/Users/akirwan/web-code/.yarn/sdks",
          -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
          workingDirectory = { mode = "auto" },
        },
      },
      vtsls = {
        settings = {
          typescript = {
            preferences = {
              includePackageJsonAutoImports = "off",
            },
            tsserver = {
              maxTsServerMemory = 8192,
            },
            tsdk = "/Users/akirwan/web-code/.yarn/sdks/typescript/lib",
          },
        },
        documentFormattingProvider = false,
      },
      ulsp = {},
    },
    setup = {
      eslint = function()
        require("lazyvim.util").lsp.on_attach(function(client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          elseif client.name == "vtsls" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
      ulsp = function(_, opts)
        local lspconfig = require("lspconfig")
        local configs = require("lspconfig.configs")

        if not configs.ulsp then
          configs.ulsp = {
            default_config = {
              cmd = { "socat", "-", "tcp:localhost:27883,ignoreeof" },
              flags = {
                debounce_text_changes = 1000,
              },
              -- capabilities = vim.lsp.protocol.make_client_capabilities(),
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
            docs = {
              description = [[
  uLSP brought to you by the IDE team!
  By utilizing uLSP in Neovim, you acknowledge that this integration is provided 'as-is' with no warranty, express or implied.
  We make no guarantees regarding its functionality, performance, or suitability for any purpose, and absolutely no support will be provided.
  Use at your own risk, and may the code gods have mercy on your soul
]],
            },
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
