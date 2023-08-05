require('neodev').setup({
   library = { plugins = { 'nvim-dap-ui' }, types = true },
 })

local dap, dapui = require("dap"), require("dapui")
require('dap-go').setup()

dap.adapters.delve = {
  type = 'server',
  port = 2345,
}
dap.configurations.go = {
  {
    type = 'delve',
    request = 'attach',
    name = 'Attach to Go',
    mode = 'remote',
    substitutePath = {
      {
        from = "${env:GOPATH}/src",
        to = "src"
      },
      {
        from = "${env:GOPATH}/bazel-go-code/external/",
        to = "external/"
      },
      {
        from = "${env:GOPATH}/bazel-out/",
        to = "bazel-out/"
      },
      {
        from = "${env:GOPATH}/bazel-go-code/external/go_sdk",
        to = "GOROOT/"
      },
    },
  },
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

vim.keymap.set('n', '<F5>', require 'dap'.continue)
vim.keymap.set('n', '<F10>', require 'dap'.step_over)
vim.keymap.set('n', '<F11>', require 'dap'.step_into)
vim.keymap.set('n', '<F12>', require 'dap'.step_out)
vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)
