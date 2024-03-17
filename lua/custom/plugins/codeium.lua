vim.g.codeium_disable_bindings = 1


-- Remove the `use` here if you're using folke/lazy.nvim.
return {
    'Exafunction/codeium.vim',
    config = function ()
        -- Change '<C-g>' here to any keycode you like.
        vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
        vim.keymap.set('i', '<c-w>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
    end
}
