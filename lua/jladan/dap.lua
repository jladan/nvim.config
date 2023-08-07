local dap = require('dap')

local function log_point()
    local cond = vim.fn.input("Log point message: ")
    dap.set_breakpoint(cond)
end

local function conditional_breakpoint()
    local cond = vim.fn.input("Breakpoint condition: ")
    dap.set_breakpoint(cond)
end


vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<F1>", dap.step_into)
vim.keymap.set("n", "<F2>", dap.step_over)
vim.keymap.set("n", "<F3>", dap.step_out)
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dB", conditional_breakpoint)
vim.keymap.set("n", "<leader>dl", log_point)
vim.keymap.set("n", "<leader>dr", dap.repl.open)

require("dap-go").setup()
require("dapui").setup()

-- The go debugger is set  up using nvim-dap-go
-- dap.adapters.delve = {
--     type = 'server',
--     port = '${port}',
--     executable = {
--         command = 'dlv',
--         args = {'dap', '-l', '127.0.0.1:${port}'},
--     }
-- }

-- dap.configurations.go = {
--     {
--         type = "delve",
--         name = "Debug",
--         request = "launch",
--         program = "${file}"
--     },
--     {
--         type = "delve",
--         name = "Debug test", -- configuration for debugging test files
--         request = "launch",
--         mode = "test",
--         program = "${file}"
--     },
--     -- works with go.mod packages and sub packages 
--     {
--         type = "delve",
--         name = "Debug test (go.mod)",
--         request = "launch",
--         mode = "test",
--         program = "./${relativeFileDirname}"
--     } 
-- }
