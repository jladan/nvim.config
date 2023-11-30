-- LSP configuration
-- based on the lspconfig example, and
-- also tj's dotfiles https://github.com/tjdevries/config_manager/tree/master/xdg_config/nvim


-- Safe load and skip if lsp isn't installed
local has_lsp, lspconfig = pcall(require, 'lspconfig')
if not has_lsp then
    return
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Use a loop to conveniently call 'setup' on multiple servers
local servers = { 
    pyright = true, 
    texlab = true, 
    -- rust_analyzer' = true,
    eslint = true,
    tsserver = true,
    tailwindcss = true,
    gopls = true,
    ocamllsp = {
        -- cmd = { "/home/tjdevries/git/ocaml-lsp/_build/default/ocaml-lsp-server/bin/main.exe" },
        settings = {
            codelens = { enable = true },
        },

        get_language_id = function(_, ftype)
            return ftype
        end,
    },
    elixirls = {
        cmd = {"/home/jladan/.local/share/nvim/mason/packages/elixir-ls/language_server.sh"},
        settings = {
            elixirLS = {
                dialyzerEnabled = false,
                fetchDeps = false
            }
        }
    }
}

local setup_server = function(server, config)
    if not config then
        return
    end

    if type(config) ~= "table" then
        config = {}
    end

    config = vim.tbl_deep_extend("force", {
        -- on_init = custom_init,
        -- on_attach = on_attach,
        capabilities = capabilities,
    }, config)

    lspconfig[server].setup(config)
end

for lsp, config in pairs(servers) do
    -- for opts, see :help lspconfig-setup
    setup_server(lsp, config)
end


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(ev)
    --Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc =  'v:lua.vim.lsp.omnifunc'

    -- Mappings.
    local opts = {buffer = ev.buf}

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = on_attach,
})


-- [[ This creates an error for some reason
-- local sumneko_root_path = vim.fn.expand('~/.local/src/lua-language-server')
-- local sumneko_binary = sumneko_root_path .. '/bin/Linux/lua-language-server'
-- 
-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")
-- 
-- require'lspconfig'.sumneko_lua.setup {
--     cmd = {sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua"};
--     settings = {
--         Lua = {
--         runtime = {
--             -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--             version = 'LuaJIT',
--             -- Setup your lua path
--             path = runtime_path,
--         },
--         diagnostics = {
--             -- Get the language server to recognize the `vim` global
--             globals = {'vim'},
--         },
--         workspace = {
--             -- Make the server aware of Neovim runtime files
--             library = vim.api.nvim_get_runtime_file("", true),
--         },
--         -- Do not send telemetry data containing a randomized but unique identifier
--         telemetry = {
--             enable = false,
--         },
--         },
--     },
-- }
-- ]]
