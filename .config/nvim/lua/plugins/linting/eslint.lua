return {
  "neovim/nvim-lspconfig",
  opts = {
    ---@type lspconfig.options
    servers = {
      eslint = {
        settings = {
          nodePath = "/Users/akirwan/web-code/.yarn/sdks",
          -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
          workingDirectory = { mode = "auto" },
        },
      },
    },
    setup = {
      eslint = function()
        require("lazyvim.util").lsp.on_attach(function(client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
    },
  },
}
