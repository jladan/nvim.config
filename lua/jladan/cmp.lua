-- Autocompletion with cmp

local hascmp, cmp = pcall(require, 'cmp')
if not hascmp then
    return
end

cmp.setup({
    snippet = {
        -- Snippet engine must be specified
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-h>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp_signature_help' },
    }, {
        -- { name = 'buffer'},
    }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        fields = {'menu', 'abbr', 'kind'},
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = 'λ',
                vsnip = '⋗',
                buffer = 'Ω',
                path = '🖫',
            }
            item.menu = menu_icon[entry.source.name]
            return require("tailwindcss-colorizer-cmp").formatter(entry, item)
        end,
    },
})

-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- require('lspconfig')['rust_analyzer'].setup {
--     capabilities = capabilities
-- }
