-- Remove the `use` here if you're using folke/lazy.nvim.
return {
    'benlubas/molten-nvim',
    enabled = true,
    build = ":UpdateRemotePlugins",
    init = function ()
        vim.g.molten_auto_image_popup = false
        vim.keymap.set('n', '<localleader>mi', ":MoltenInit<CR>",
            { silent = true, desc = "Initialize Molten" })
        vim.keymap.set('n', '<localleader>e', ":MoltenEvaluateOperator<CR>",
            { silent = true, desc = "Run operator selection" })
        vim.keymap.set('v', '<localleader>e', ":<C-u>MoltenEvaluateVisual<CR>",
            { silent = true, desc = "evaluate visual selection" })
    end
}
