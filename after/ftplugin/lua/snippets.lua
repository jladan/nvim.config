-- Defining snippets for latex

local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

local function copy(args)
    return args[1]
end

ls.config.set_config({
    history=true,
    updateevents = 'TextChanged, TextChangedI',
})

ls.add_snippets("lua", {
    s("if", {
        t("if "), i(1), t({" then", "\t"}),
        i(2),
        t({ "", "end", "" }),
    }),
    s("for", {
        t("for "), i(1), t({" do", "\t"}),
        i(2),
        t({ "", "end", "" }),
    }),
}, {
    key = "lua",
})
