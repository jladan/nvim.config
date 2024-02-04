--[[ 

# Common keymaps that I like

These were built up over time, and mostly are just vim key sequence conveniences.

Rewritten in lua, so that descriptions are included when looking at my keymaps.
--]]

--[[ macro to help changing from vim to lua keymappings (yank whole line into any register except `t`)
^"txciwvim.keymap.set({ 't', },wi"Ea",wi"A", { desc = "XXX" })
--]]

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

--[[
-- TODO: un-map <C-space> completely so I can use it as a leader
-- In insert mode, I use <C-space> as a leader, but <C-space><C-space> defaults
-- to repeating thet  last insert mode command.
-- My keyboard has also started double-tapping space, which is really annoying.
-- This fixes that issue
imap <C-space><C-space> <C-space>
nmap <space><space> <space>

-- Generalized underline characters
nnoremap <leader>u :t .<CR>^v$r
inoremap <expr> <C-space>u "<C-\><c-N>:t .<CR>^v$r" . nr2char(getchar()) . "o"

-- To help with code refactoring, search through all files for current word
nnoremap <silent> <leader>r :vimgrep <cword> **/*.py<cr>:cope<cr><C-W>p

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

snoremap <silent> <C-t> <cmd>lua require'luasnip'.jump(1)<cr>
snoremap <silent> <CS-t> <cmd>lua require'luasnip'.jump(-1)<cr>

imap <silent><expr> <C-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>'
smap <silent><expr> <C-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>'

-- TODO undotree keymap
nnoremap <leader>u :UndotreeToggle<CR>
--]]
