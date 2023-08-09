local dap = require('dap')

local function log_point()
    local cond = vim.fn.input("Log point message: ")
    dap.set_breakpoint(cond)
end

local function conditional_breakpoint()
    local cond = vim.fn.input("Breakpoint condition: ")
    dap.set_breakpoint(cond)
end


vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F1>", dap.step_into)
vim.keymap.set("n", "<F2>", dap.step_over)
vim.keymap.set("n", "<F3>", dap.step_out)
vim.keymap.set("n", "<leader>dq", dap.close)
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>B", conditional_breakpoint)
vim.keymap.set("n", "<leader>lp", log_point)
vim.keymap.set("n", "<leader>dr", dap.repl.open)
vim.keymap.set("n", "<leader>do", require"dapui".open)
vim.keymap.set("n", "<leader>dc", require"dapui".close)
vim.keymap.set("n", "<leader>dt", require"dap-go".debug_test)

-- Go debugger using delve
require("dap-go").setup()

require("dapui").setup({
    icons = { expanded = "▼", collapsed = "►", current_frame = "◎◆" },
    controls = {
        icons = {
            pause = "➤",
            play = "►",
            step_into = "⤓",
            step_over = "🠊",
            step_out = "⤒",
            step_back = "🠈",
            run_last = "↻",
            terminate = "☒",
        },
    },
})


-- dap.adapters.rust_lldb = {
--     id = "rust-lldb",
--     type = 'executable',
--     command = "rust-lldb",
-- }


dap.configurations.rust = {
    {
        name = "Launch codelldb",
        type = "rt_lldb",
        request = "launch",
        program = function()
            return vim.fn.input( "Path to executable", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
    },
--     {
--         name = "Launch lldb",
--         type = "rust_lldb",
--         request = "launch",
--         program = function()
--             return vim.fn.input( "Path to executable", vim.fn.getcwd() .. "/", "file")
--         end,
--         cwd = "${workspaceFolder}",
--         stopOnEntry = false,
--         args = {},
--         runInTerminal = false,
--     },
}

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
