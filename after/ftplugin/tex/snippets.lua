-- Defining snippets for latex

local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

local rec_ls = function()
    return sn(
        nil,
        c(1, {t(""), sn(nil, { t({"", "\t\\item "}), i(1), d(2, rec_ls, {}) }), })
    )
end

local lower_dash = function(args)
    local text = args[1][1]
    text = text:gsub(" ", "-"):lower()
    return text
end

local function copy(args)
    return args[1]
end

local function head_snip(trigger, style, label_prefix)
    return s(trigger, {
            t("\\" .. style .. "{"), i(1, "section name"), t({"}", ""}),
            t("\\label{" .. label_prefix .. ":"), f(lower_dash, 1), t({"}", ""}),
        })
end


ls.config.set_config({
    history=true,
    updateevents = 'TextChanged, TextChangedI',
})

ls.snippets = {
    tex = {
        s("ls", {
            t({ "\\begin{itemize}", "\t\\item "}),
            i(1),
            d(2, rec_ls, {}),
            t({ "", "\\end{itemize}" }),
        }),
        head_snip("sec", "section", "sec"),
        head_snip("ssec", "subsection", "sec"),
        head_snip("sssec", "subsubsection", "sec"),
        head_snip("cha", "chapter", "ch"),
        s("fig", {
            t({ "\\begin{figure}",
                "\t\\begin{center}", ""}),
            t("\t\t\\includegraphics[width=.95\\textwidth]{figures/"), i(1), t({"}", ""}),
            t({"\t\\end{center}", ""}),
            t("\\caption{"), i(2), t({"}", ""}),
            t("\\label{fig:"), i(3), t({"}", ""}),
            t({ "\\end{figure}", ""}),
        }),
        s("env", {
            t("\\begin{"), i(1), t({"}", ""}),
            t("\t"), i(0), 
            t({"", "\\end{"}), f(copy, 1), t({"}", ""}),
        }),
    },
}
