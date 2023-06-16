-- load custom grammar for org filetype
require('orgmode').setup_ts_grammar()

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,
    -- disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = {'org'},
  },
  textobjects = {
      -- Refer to https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      select = {
          enable = true,
          -- Automatically jump forward to text obj
          lookahead = true,

          keymaps = {
              -- You can use the capture groupse defined in textobjects.scm
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" }
          },
          selection_modes = {
              ['@parameter.outer'] = 'v',
              ['@function.outer'] = 'V',
              ['@class.outer'] = 'V',
          },
          -- If set to `true`, then objects extended to include preceding or succeeding whitespace.
          include_surrounding_whitespace = false,
      },
      swap = {
          enable = true,
          swap_next = {
              ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
              ["<leader>A"] = "@parameter.inner",
          },
      },
      -- move {} can be used to define section like movements (TODO)
  }
}
