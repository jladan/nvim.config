-- Functions used in init (just for code organization

local M = {}

function M.os_config()
    -- Set shell on windows
    -- alternatively, use vim.fn.has('macunix'), but cannot find in helpfiles
    if vim.loop.os_uname().sysname == 'Windows_NT' then
        -- see :h shell-powershell
        vim.go.shell = "powershell.exe"
        -- vim.go.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
        vim.go.shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[\'Out-File:Encoding\']=\'utf8\';'
        vim.go.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
        vim.go.shellpipe  = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
        vim.go.shellquote= ''
        vim.go.shellxquote=''
    end

end

function M.new_scratch(opts)
    -- TODO: if on unnamed, then convert current to scratch
    local bufnr = vim.api.nvim_create_buf(true, true)
    local cmd = {
        cmd = 'buffer',
        range = {bufnr},
        mods = opts.smods,
    }

    if opts.smods.vertical or opts.smods.horizontal or opts.smods.tab >= 0 then
        cmd.cmd = 'sbuffer'
    end

    vim.api.nvim_cmd(cmd, {})
end

function M.setup_scratch()
    vim.api.nvim_create_user_command('Scratch', M.new_scratch, {})
    vim.api.nvim_create_user_command('S', M.new_scratch, {})
end

return M
