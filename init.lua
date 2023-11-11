vim.g.mapleader = ' ' 
vim.g.maplocalleader = ' ' 

vim.cmd [[
    colorscheme  jladan
    hi CursorLine cterm=undercurl guisp=DarkMagenta
]]

-- 2-space files
vim.cmd [[
    colorscheme  jladan
    hi CursorLine cterm=undercurl guisp=DarkMagenta
    au Filetype html setlocal ts=2 sw=2 expandtab
    au Filetype css setlocal ts=2 sw=2 expandtab
    au Filetype javascript setlocal ts=2 sw=2 expandtab
    au Filetype javascriptreact setlocal ts=2 sw=2 expandtab
    au Filetype typescript setlocal ts=2 sw=2 expandtab
    au Filetype json setlocal ts=2 sw=2 expandtab
]]


-- TODO: reconfigure snippets
--       - global rather than ftype?
--       - reloadable by sourcing lua
--       - go over the teej_dv videos for ideas
require('jladan.packer')

require('jladan.telescope')
require('jladan.treesitter')
require('jladan.cmp')
require('jladan.lsp')

require("jladan.dap")

require("mason").setup()
require('mason-lspconfig').setup()

-- Rust-tools setup
local rt = require("rust-tools")

local extension_path = '/home/jladan/.local/share/nvim/mason/packages/codelldb/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb'

local this_os = vim.loop.os_uname().sysname;

-- The path in windows is different
if this_os:find "Windows" then
  codelldb_path = extension_path .. "adapter\\codelldb.exe"
  liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
else
  -- The liblldb extension is .so for linux and .dylib for macOS
  liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
end

rt.setup({
    server = {
        on_attach = function(_, bufnr)
            vim.keymap.set("n", "K", rt.hover_actions.hoveractions, { buffer = bufnr })
            vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
    },
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
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

-- Snippets (general)
local ls = require("luasnip")

ls.config.set_config({
    history=false,
    delete_check_events='InsertLeave',
})


local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

local function copy(args)
    return args[1]
end

ls.add_snippets("markdown", {
    s("head", {
        t("# "), i(1),
        t({"", "", "```toml", "date = "}), i(2),
        t({"", "tags = ["}), i(3), t("]"),
        t({"", "```", ""}),
    }),
}, {
    key = "notes",
})
