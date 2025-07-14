local ls = require("luasnip")

-- this is a snippet creator:
-- s(<trigger>, <nodes>)
local s = ls.snippet

-- This is a formatting node.
-- It takes a format string, and a list of nodes
-- fmt(<ftm string>, {...nodes})
local fmt = require("luasnip.extras.fmt").fmt

-- This is a repeating node.
-- It take a position, which is matched to some of your other node positions,
-- and repeats the value entered
local rep = require("luasnip.extras").rep

-- This is an insert node
-- It takes a position (like $1) and optionally some default text
-- i(<position>, [default text])
local i = ls.insert_node

local t = ls.text_node
local f = ls.function_node


local function python_function_doc_string(args)
    local py_doc_string = [[
    """
        {} function description here.

        {}: {}
            - {}.

        returns
            {}.
    """
    ]]
    return py_doc_string
end

local function python_function_def_string(args)
    local py_func_string = [[
        def {}({}:{}):
        """
            {} function description here.

            {}: {}
                - {}.

            returns
                {}.
        """
            return {}
        ]]
    return py_func_string
end

-- ls.parse.parse_snippet(<text>, <VSCode style snippet>)
ls.add_snippets("all", {
    -- create a python function definition with automated docstring
    s("def_function",
        fmt(
            python_function_def_string(),
            {
                i(1, "my_function"), i(2, "arg1"), i(3, "type"),
                rep(1),
                rep(2), rep(3),
                i(4, "arg_description"),
                i(5, "return_description"),
                i(0)
            }
        )
    ),
})

-- python snippets
ls.add_snippets("python", {
})
-- lua snippets
ls.add_snippets("lua", {
    ls.parser.parse_snippet("local function", "local $1 = function($2)\n    $0\n end"),
})
