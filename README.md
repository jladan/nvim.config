# Just my neovim config files

This has grown a lot since I started

## Features

### General

- Keymaps defined in `plugin/keymaps` include
    - quickfix and buffer navigation
    - underlining text
    - copying to clipboard
    - moving text up and down lines
- Fancy status line in `init.vim` that uses color to show current window and if
  the file is modified. Also, filetype, position, etc.
- Often-used insertions (time and date) in `plugin/meta-data.vim`
- show word count of visual selection with <C-g> (`plugin/word-count`)
- overly complicated colorscheme that I made years ago
    - also provides a lightmode scheme automaticall with `:set bg=light`

### Plugins

Installed with vim-plug, which is also auto-installed
- A Telescope for a menu to select things in addition to the builtins, I have
    - neovim config files
    - "diary" for quick access to things in my diary
- luasnip for snippets
- fugitive for git commands from inside vim
- LSP half baked config

### LaTeX editing

- synctex is partially implemented in `after/ftplugin/tex.vim`
- jump to next section or float with `]]`, `][`, etc in `after/ftplugin/tex/sections.vim`
- snippets for section headings, environments, and some math
  `after/ftplugin/tex/snippets.lua`

I also use my own `nvim-latex` plugin that provides an outline of the document,
and inserts crossreferences and citations.

