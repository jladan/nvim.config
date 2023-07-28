vim.g.mapleader = ' ' 
vim.g.maplocalleader = ' ' 

vim.cmd [[
    colorscheme  jladan
    hi CursorLine cterm=undercurl guisp=DarkMagenta
]]


require('jladan.packer')

require('jladan.telescope')
require('jladan.treesitter')
require('jladan.lsp')
require('jladan.cmp')

require("mason").setup()
require('mason-lspconfig').setup()

-- Rust-tools setup
local rt = require("rust-tools")

rt.setup({
    server = {
        on_attach = function(_, bufnr)
            vim.keymap.set("n", "<C-k>", rt.hover_actions.hoveractions, { buffer = bufnr })
            vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
    },
})


-- Highlighting todos and such

require("todo-comments").setup({
    highlight = { 
        pattern = [[.*<(KEYWORDS)\s*]],
        keyword = "fg",
        after = "",
    },
    keywords = { 
        FIX = { hlgroup = "Error" },
        TODO = { hlgroup = "Todo" },
        HACK = { hlgroup = "DiagnosticWarn" },
        WARN = { hlgroup = "DiagnosticWarn" },
        PERF = { hlgroup = "Todo" },
        NOTE = { hlgroup = "DiagnosticOk" },
        TEST = { hlgroup = "Todo" },
    },
    search = {
        pattern = [[\b(KEYWORDS)\b]],
    },
})

local tc = require("todo-comments")
vim.keymap.set("n", "]t", tc.jump_next, {desc = "Next todo comment" })
vim.keymap.set("n", "[t", tc.jump_prev, {desc = "Previous todo comment" })
