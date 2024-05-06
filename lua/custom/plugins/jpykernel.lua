return {
    'lkhphuc/jupyter-kernel.nvim',
    enabled = false,
    opts = {
        inspect = {
            window = { max_width = 80 },
        },
        timeout = 0.5,
    },
    cmd = {"JupyterAttach", "JupyterInspect", "JupyterExecute", "JupyterKernels"},
    build = ":UpdateRemotePlugins",
    keys = { { "<leader>k", "<Cmd>JupyterInspect<CR>", desc = "Inspect object in kernel" } },
}
