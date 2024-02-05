
-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- Set shell on windows
-- alternatively, use vim.fn.has('macunix'), but cannot find in helpfiles
if vim.loop.os_uname().sysname == 'Windows_NT' then
    vim.g.shell = "powershell.exe"
end

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({

    -- Carry over from previous
    'folke/todo-comments.nvim',
    'mbbill/undotree',

    --[[ Debugging
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    'leoluz/nvim-dap-go',
    -- use 'nvim-telescoope/telescope-dap.nvim'

    -- HTML snippets
    'mattn/emmet-vim',
    'dcampos/cmp-emmet-vim',
    -- ]]

    -- Git related
    'tpope/vim-fugitive',
    -- 'tpope/vim-rhubarb', -- Only looks to support github, not gitlab

    -- Detect tabstop and shiftwidth automatically
    -- 'tpope/vim-sleuth',

    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
        },

        {
            -- Autocompletion
            'hrsh7th/nvim-cmp',
            dependencies = {
                -- Snippet Engine & its associated nvim-cmp source
                'L3MON4D3/LuaSnip',
                'saadparwaiz1/cmp_luasnip',

                -- Adds LSP completion capabilities
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-path',

                -- Adds a number of user-friendly snippets
                -- Kept for reference, but I prefer rolling my own
                -- 'rafamadriz/friendly-snippets',
            },
        },
    },

    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help ibl`
        main = 'ibl',
        opts = {
            indent = {
                char = '┊'
            },
        },
    },

    -- "gc" to comment visual regions/lines
    -- TODO: better key for block comments
    { 'numToStr/Comment.nvim', opts = {} },

    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },

    -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
    --       These are some example plugins that I've included in the kickstart repository.
    --       Uncomment any of the lines below to enable them.
    -- require 'kickstart.plugins.autoformat',
    -- require 'kickstart.plugins.debug',

    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
    --    up-to-date with whatever is in the kickstart repo.
    --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
    --
    --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
    -- { import = 'custom.plugins' },

})

