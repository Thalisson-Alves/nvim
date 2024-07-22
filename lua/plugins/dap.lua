return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "theHamsta/nvim-dap-virtual-text",
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
      config = true,
    }
  },
  setup = function()
    local dap = require("dap")
    dap.adapters.cpp = {
      type = "executable",
      command = "lldb-vscode",
      name = "lldb",
    }
    dap.configurations.cpp = {
      {
        name = "Launch",
        type = "cpp",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
        args = {},
        runInTerminal = false,
      },
    }
    dap.adapters.python = {
      type = "executable",
      command = "python3",
      args = { "-m", "debugpy.adapter" },
    }
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          return vim.fn.input("Path to python interpreter: ", vim.fn.exepath("python3"), "file")
        end,
      },
    }
  end,
  keys = {
    { "<leader>dc", "<cmd>lua require('dap').continue()<CR>",          desc = "Continue" },
    { "<leader>dr", "<cmd>lua require('dap').repl.toggle()<CR>",       desc = "Repl" },
    { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", desc = "Toggle breakpoint" },
    { "<leader>dn", "<cmd>lua require('dap').step_over()<CR>",         desc = "Step over" },
    { "<leader>ds", "<cmd>lua require('dap').step_into()<CR>",         desc = "Step into" },
    { "<leader>do", "<cmd>lua require('dap').step_out()<CR>",          desc = "Step out" },
    { "<leader>dl", "<cmd>lua require('dap').run_last()<CR>",          desc = "Run last" },
    { "<leader>du", "<cmd>lua require('dapui').toggle()<CR>",          desc = "Toggle UI" },
  },
}
