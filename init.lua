vim.g.mapleader = ' ' 
vim.g.maplocalleader = ' ' 

vim.cmd [[
    colorscheme  jladan
    hi CursorLine cterm=undercurl guisp=DarkMagenta
]]


require('jladan.packer')

require('jladan.telescope')
require('jladan.treesitter')
