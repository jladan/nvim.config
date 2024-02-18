--[[ 

# Common keymaps that I like

These were built up over time, and mostly are just vim key sequence conveniences.

Rewritten in lua, so that descriptions are included when looking at my keymaps.
--]]

--[[ macro to help changing from vim to lua keymappings (yank whole line into any register except `t`)
^"txciwvim.keymap.set({ 't', },wi"Ea",wi"A", { desc = "XXX" })
--]]

-- Ignore leader key (normally jumps ahead)
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- I also use <C-space> as leader in insert mode (normally repeats last insert command)
vim.keymap.set({ 'i' }, '<C-Space>', '<Nop>', { silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- TODO possibly different keys for these
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


-- I kept accidentally doing <c-z><c-z> instead of ZZ, so this fixes it and
-- adds saving
vim.keymap.set('n', '<C-Z>', "<cmd>w<CR>", { silent=true, desc="save file" })

-- Go to a file even if it doesn't exist
vim.keymap.set({ 'n', },  "gF", ":e <cfile><CR>", { silent=true, desc = "Jump to file (even if it doesn't exist)" })

-- My down-arrow is below j, so sometimes I hit <S-Down> instead of J
vim.keymap.set({ 'n', }, "<S-Down>", "J", { desc = "join to next line (backup)" })

-- Shortcuts into the <C-X> completion menu
vim.keymap.set('i', "<C-F>", "<C-X><C-F>", { desc="complete filename"})
vim.keymap.set('i', "<C-L>", "<C-X><C-L>", { desc="complete line"})

-- Underlining commands for comments and markdown
vim.keymap.set('i', "<C-space>-", "<C-\\><c-N>:t .<CR>^v$r-o", { silent=true, desc="single underline"})
vim.keymap.set('i', "<C-space>=", "<C-\\><c-N>:t .<CR>^v$r=o", { silent=true, desc="double underline"})

-- buffer navigation
vim.keymap.set({ 'n', }, "]e", ":bn<cr>", { silent=true, desc = "next open buffer" })
vim.keymap.set({ 'n', }, "]E", ":bp<cr>", { silent=true, desc = "prev open buffer" })
vim.keymap.set({ 'n', }, "]<space>", ":b<space>", { desc = "open buffer (selection)" })
vim.keymap.set({ 'n', }, "]<C-space>", ":sb<space>", { desc = "split open buffer (selection)" })

--" The following from ThePrimeagen
-- Improved copying
vim.keymap.set({ 'n', }, "<leader>y", "\"+y", { desc = "XXX" })
vim.keymap.set({ 'v', }, "<leader>y", "\"+y", { desc = "XXX" })
vim.keymap.set({ 'n', }, "<leader>Y", "gg\"+yG", { desc = "XXX" })
vim.keymap.set({ 'n', }, "<leader>p", "\"+p", { desc = "XXX" })
vim.keymap.set({ 'n', }, "<leader>P", "\"+P", { desc = "XXX" })
vim.keymap.set({ 'v', }, "<leader>p", "\"+p", { desc = "XXX" })

-- Moving text
-- TODO: maybe re-add `=` to take care of indenting
-- TODO: counts for more substantial moves
-- TODO: move to marker would be cool
vim.keymap.set({ 'v', }, "J", ":m '>+1<CR>gv", { desc = "XXX" })
vim.keymap.set({ 'v', }, "K", ":m '<-2<CR>gv", { desc = "XXX" })
vim.keymap.set({ 'n', }, "<leader>j", ":m .+1<CR>", { desc = "XXX" })
vim.keymap.set({ 'n', }, "<leader>k", ":m .-2<CR>", { desc = "XXX" })

--[[ local luasnip = require('luasnip')
vim.keymap.set({ 's', }, "<C-t>", "<cmd>lua require'luasnip'.jump(1)<cr>", { silent=true, desc = "XXX" })
vim.keymap.set({ 's', }, "<CS-t>", "<cmd>lua require'luasnip'.jump(-1)<cr>", { silent=true, desc = "XXX" })

local function next_choice()
    if luasnip.choice_active() then
        luasnip.next_choice()
    end
end
vim.keymap.set({ 'i', 's', }, "<C-e>", next_choice, { silent=true,  desc = "XXX" }) ]]

--[[

-- Generalized underline characters
nnoremap <leader>u :t .<CR>^v$r
inoremap <expr> <C-space>u "<C-\><c-N>:t .<CR>^v$r" . nr2char(getchar()) . "o"

-- Navigate the quickfix list
nnoremap <silent> ]U :cp<cr>
nnoremap <silent> ]u :cn<cr>
-- TODO navigate loclist too?

-- Snippets
-- note: the expression allows overloading tab, which I normally don't like
--imap <silent><expr> <tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<tab>'
--inoremap <silent> <C-t> <Plug>luasnip-expand-or-jump
imap <silent><expr> <C-t> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-t>'
inoremap <silent> <CS-t> <cmd>lua require'luasnip'.jump(-1)<cr>

-- ]]
--[[
-- TODO undotree keymap
nnoremap <leader>u :UndotreeToggle<CR> 
-- ]]
