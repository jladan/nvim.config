-- Install/bootstrap the package manager
local ensure_packer = function()
    local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.fn.system({
            'git', 'clone', '--depth', '1',
            'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

local packer = require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {'williamboman/mason.nvim', run = ':MasonUpdate'}
    use 'williamboman/mason-lspconfig.nvim'

    -- General purpose
    use 'nvim-lua/plenary.nvim'
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.1',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'neovim/nvim-lspconfig'

    -- Autocomplete
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-nvim-lua'

    -- TODO highlighting and searching
    use 'folke/todo-comments.nvim'

    use 'tpope/vim-commentary'

    -- Languages
    use 'simrat39/rust-tools.nvim'

    -- Debugging
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'leoluz/nvim-dap-go'
    -- use 'nvim-telescoope/telescope-dap.nvim'

    -- Snippets
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'mattn/emmet-vim'
    use 'dcampos/cmp-emmet-vim'

    -- Actually super cool
    use 'mbbill/undotree'

    -- Git in vim
    use 'tpope/vim-fugitive'

    -- Treesitter does language parsing
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    -- Things to make developing with lua easier
    use 'bfredl/nvim-luadev'

    -- Orgmode
    use {'nvim-orgmode/orgmode', config = function()
            require('orgmode').setup{}
        end
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end)

vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]]

