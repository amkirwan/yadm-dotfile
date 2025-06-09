-- Launch or attach to a running Javascript/Typescript process
local jsOrTs = {
  {
    type = "node2",
    name = "Launch",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    type = "node2",
    name = "Attach",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    name = "Vitest Debug",
    type = "pwa-node",
    request = "launch",
    cwd = vim.fn.getcwd(),
    program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
    args = { "--threads", "false", "run", "${file}" },
    autoAttachChildProcesses = true,
    smartStep = true,
    console = "integratedTerminal",
    skipFiles = { "<node_internals>/**", "node_modules/**" },
  },
}

local chrome_debugger = {
  type = "pwa-chrome",
  request = "launch",
  name = "Chrome",
  webRoot = "${workspaceFolder}",
}

local function get_arguments()
  local co = coroutine.running()
  if co then
    return coroutine.create(function()
      local args = {}
      vim.ui.input({ prompt = "Args: " }, function(input)
        args = vim.split(input or "", " ")
      end)
      coroutine.resume(co, args)
    end)
  else
    local args = {}
    vim.ui.input({ prompt = "Args: " }, function(input)
      args = vim.split(input or "", " ")
    end)
    return args
  end
end

local go = {
  {
    type = "delve",
    request = "attach",
    name = "Attach to Go",
    mode = "remote",
    substitutePath = {
      {
        from = "${env:GOPATH}/src",
        to = "src",
      },
      {
        from = "${env:GOPATH}/bazel-go-code/external/",
        to = "external/",
      },
      {
        from = "${env:GOPATH}/bazel-out/",
        to = "bazel-out/",
      },
      {
        from = "${env:GOPATH}/bazel-go-code/external/go_sdk",
        to = "GOROOT/",
      },
    },
  },
}

return {
  setup = function(dap)
    dap.configurations = {
      javascript = jsOrTs,
      typescript = jsOrTs,
      javascriptreact = chrome_debugger,
      vue = chrome_debugger,
      go = go,
    }
  end,
}
