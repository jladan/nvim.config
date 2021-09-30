-- Inspired by theprimeagen and tjdevries

-- Just the mappings for now, no special pickers

local sorters = require "telescope.sorters"

-- Setup (straight from theprimeagen
require("telescope").setup({
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,

        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = require("telescope.actions").send_to_qflist,
            },
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
})

TelescopeMarArgs = TelescopeMarArgs or {}

-- Convenience to the mapping lines simpler
local map_tele = function(key, f, options, buffer)
    local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

    TelescopeMarArgs[map_key] = options or {}

    local mode = "n"
    local rhs = string.format("<cmd>lua require('jladan.telescope')['%s'](TelescopeMarArgs['%s'])<CR>", f, map_key)

    local map_options = {
        noremap = true,
        silent = true,
    }

    if not buffer then
        vim.api.nvim_set_keymap(mode, key, rhs, map_options)
    else
        vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
    end
end

-- No idea what this is
vim.api.nvim_set_keymap("c", "<c-r><c-r", "<Plug>(TelescopeFuzzyCommandSearch)", { noremap = palse, nowait = true })



-- Search
-- TODO figure out why grep_string doesn't work
map_tele("<leader>tw", "grep_string", {
    -- TODO learn what these options mean
    short_path = true,
    word_match = "-w",
    only_sort_text = true,
    layout_strategy = "vertical",
    sorter = sorters.get_fzy_sorter(),
})

-- Files
map_tele("<leader>tg", "git_files")
map_tele("<leader>t<space>", "buffers")
map_tele("<leader>te", "find_files")

-- Help
map_tele("<leader>th", "help_tags")

-- Telescope Meta
map_tele("<leader>tt", "builtin")


-- The pickers that I use
-- All builtins for now

local builtin = require "telescope.builtin"

local M = {}
M.grep_string = builtin.grep_string
M.git_files = builtin.git_files
M.buffers = builtin.buffers
M.find_files = builtin.find_files
M.help_tags = builtin.help_tags

M.builtin = builtin.builtin

return M
