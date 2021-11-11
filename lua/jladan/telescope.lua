-- Inspired by theprimeagen and tjdevries

-- Just the mappings for now, no special pickers

local sorters = require "telescope.sorters"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

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

-- A global variable to track the arguments for each key map
TelescopeMapArgs = TelescopeMapArgs or {}

-- (taken from tjdevries)
-- Just sets the prompt to the selected entry I don't really see the point
local set_prompt_to_entry_value = function(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    if not entry or not type(entry) == "table" then
        return
    end

    action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

-- Convenience to the mapping lines simpler
local map_tele = function(key, f, options, buffer)
    local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

    TelescopeMapArgs[map_key] = options or {}

    local mode = "n"
    local rhs = string.format("<cmd>lua require('jladan.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

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

-- XXX no idea what this is
vim.api.nvim_set_keymap("c", "<c-r><c-r", "<Plug>(TelescopeFuzzyCommandSearch)", { noremap = false, nowait = true })


-- Search
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
map_tele("<leader>tn", "edit_neovim")

map_tele("<leader>td", "edit_diary")

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

function M.edit_neovim()
    local opts_with_preview, opts_without_preview

    opts_with_preview = {
        prompt_title = "~ dotfiles ~",
        shorten_path = false,
        cwd = '~/.config/nvim',

        layout_strategy = 'flex',
        layout_config = {
            width = 0.9,
            height = 0.8,

            horizontal = {
                width = { padding = 0.15 },
            },
            vertical = {
                preview_height = 0.75,
            },
        },

        attach_mappings = function(_, map)
            map("i", "<c-y>", set_prompt_to_entry_value)
            map("i", "<M-c>", function(prompt_bufnr)
                actions.close(prompt_bufnr)
                vim.schedule(function()
                    require("telescope.builtin").find_files(opts_without_preview)
                end)
            end)

            return true
        end,
    }

    opts_without_preview = vim.deepcopy(opts_with_preview)
    opts_without_preview.previewer = false

    require("telescope.builtin").find_files(opts_with_preview)
end

function M.edit_diary()
    local opts_with_preview, opts_without_preview

    opts_with_preview = {
        prompt_title = "~ diary ~",
        shorten_path = false,
        cwd = '$diary',

        layout_strategy = 'flex',
        layout_config = {
            width = 0.9,
            height = 0.8,

            horizontal = {
                width = { padding = 0.15 },
            },
            vertical = {
                preview_height = 0.75,
            },
        },

        attach_mappings = function(_, map)
            map("i", "<c-y>", set_prompt_to_entry_value)
            map("i", "<M-c>", function(prompt_bufnr)
                actions.close(prompt_bufnr)
                vim.schedule(function()
                    require("telescope.builtin").find_files(opts_without_preview)
                end)
            end)

            return true
        end,
    }

    opts_without_preview = vim.deepcopy(opts_with_preview)
    opts_without_preview.previewer = false

    require("telescope.builtin").file_browser(opts_with_preview)
end

return M
