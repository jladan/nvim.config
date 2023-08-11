-- Autocompletion with cmp

local hascmp, cmp = pcall(require, 'cmp')
if not hascmp then
    return
end

cmp.setup({
    completion = {
        -- TODO: decide if manual completion is what I want
        autocomplete = false,
    },
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
        ['<C-s>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- TODO: make sure that this cooperates well with luasnip
        ['<C-h>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp_signature_help' },
    }, {
        { name = 'buffer'},
    }),
    window = {
        -- TODO: I don't like the bordered window, different colours would be better?
        completion = cmp.config.window.bordered(),
        -- completion = {
        --     -- TODO: create highlight groupse for Normal and CursorLine
        --     winhighlight = 'Normal:Normal,CursorLine:Visual,Search:None'
        -- },
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        -- TODO: can add 'lspkind' plugin to make customization easier
        fields = {'menu', 'abbr', 'kind'},
        format = function(entry, item)
            local menu_icon = {
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
