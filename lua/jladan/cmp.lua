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
        -- TODO: Consider changing scrolling keymaps
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- TODO: Ctrl space should definitely change, since it's my insert-mode leader
        -- TODO: Is there some way to make it optionally manual (no auto-menu, but pops up on special key)
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-h>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        -- TODO: order of these matter, can also use priority method
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp_signature_help' },
        -- TODO: add "buffer" for words in current  buffer
    }, {
        -- { name = 'buffer'},
    }),
    window = {
        -- TODO: I don't like the bordered window, different colours would be better?
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        -- TODO: can add 'lspkind' plugin to make customization easier
        fields = {'menu', 'abbr', 'kind'},
        format = function(entry, item)
            local menu_icon = {
                -- TODO, consider changing marker to  be more clear
                nvim_lsp = 'λ',
                vsnip = '⋗',
                buffer = 'Ω',
                path = '🖫',
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
})

-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- require('lspconfig')['rust_analyzer'].setup {
--     capabilities = capabilities
-- }
