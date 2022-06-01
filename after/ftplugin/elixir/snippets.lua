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

local function block_snip(trigger, style)
    return s(trigger, {
            t(style .. " "), i(1), t({" do", "\t"}),
            i(2),
            t({"", "end", ""}),
        })
end

ls.config.set_config({
    history=true,
    updateevents = 'TextChanged, TextChangedI',
})

ls.add_snippets("elixir", {
    s("doc", {
        t({ "@doc \"\"\"", ""}),
        i(1),
        t({ "", "\"\"\""}),
    }),
    s("mdoc", {
        t({ "@moduledoc \"\"\"", ""}),
        i(1),
        t({ "", "\"\"\""}),
    }),
    block_snip("def", "def"),
    block_snip("defp", "defp"),
    block_snip("case", "case"),
    block_snip("with", "with"),
}, {
    key = "elixir",
})
