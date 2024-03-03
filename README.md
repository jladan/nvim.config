# Just my neovim config files

Fresh start: Feb 2024.

Based on Kickstart, but also brought over some keymaps and config from the past 15 years.

## Features

### General

- Keymaps defined in `plugin/keymaps` include
    - insert-mode "leader" key `<c-space>`
    - buffer navigation (next: `]e`, prev: `]E`, cmdline: `]<space>`, sbuffer: `]<C-space>`
    - underlining text e.g. for markdown headers
    - copying to OS clipboard (`<leader>y`, `<leader>p`)
    - moving text up and down lines (`<leader>j` `<leader>k`)
    - faster access to line and filename completion
- Fancy status line in `init.vim` that uses color to show current window and if
  the file is modified. Also, filetype, position, etc.
- Often-used insertions (time and date) in `plugin/meta-data.vim`
- show word count of visual selection with <C-g> (`plugin/word-count`)

### Deprecated
- overly complicated colorscheme that I made years ago
    - also provides a lightmode scheme automatically with `:set bg=light`
    - deprecated, because it does not play well with new features like some treesitter highlighting

### Plugins

Installed with lazy.vim, which is auto-installed on first start
- A Telescope for a menu to select things in addition to the builtins, I have
    - neovim config files
    - live grep, files, gitfiles, etc
- luasnip for snippets
    - Not imported yet
    - using `<C-t>` so that it doesn't interfere with regular typing.
- cmp for lsp completion
    - using `<C-h>` so that it doesn't interfere with luasnip or regular typing.
- fugitive for git commands from inside vim

### LaTeX editing

**currently not included**

- synctex is partially implemented in `after/ftplugin/tex.vim`
- jump to next section or float with `]]`, `][`, etc in `after/ftplugin/tex/sections.vim`
- snippets for section headings, environments, and some math
  `after/ftplugin/tex/snippets.lua`

I also use my own `nvim-latex` plugin that provides an outline of the document,
and inserts crossreferences and citations.

