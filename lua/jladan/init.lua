-- Functions used in init (just for code organization

local M = {}

M.os_config = function()
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


return M
