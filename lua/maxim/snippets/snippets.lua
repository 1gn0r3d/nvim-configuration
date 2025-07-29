local ls = require("luasnip")
local types = require("luasnip.util.types")
require("luasnip.session.snippet_collection").clear_snippets("all")
require("luasnip.session.snippet_collection").clear_snippets("python")

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

-- This is a text node, used to just insert simply a string
local t = ls.text_node

-- This is a choice node
-- It takes a position, and then a luatable of possible nodes or options.
--  Note, you don't necessarily need to provide a jump position.
local c = ls.choice_node

-- This is a function node
-- It takes a function to call, and then a list of arguments.
-- Function nodes always return a string to insert.
local f = ls.function_node

-- This is a dynamic node
-- Rather than returning strings, these return snippets
local d = ls.dynamic_node

-- Snippet Node (necessary for returning snippets from dynamic nodes)
local sn = ls.sn
local isn = ls.indent_snippet_node

-- Restore node
local r = ls.restore_node

local function curtime()
    return os.date("%D - %H:%M")
end

local function parse_python_query(query, node, time)
    time = time or nil
    local header = [[
"""
]]
    if time ~= nil then
        header = header .. [[
{ind}Created: {time} - author:  Maxim Vanrusselt
]]
        header = header:gsub("{time}", time)
    end
    header = header .. [[
{ind}Function: %s  {func_desc}

{ind}Args:]]
    local footer = [[
{ind}Return:
{ind}   %s

{ind}"""]]


    -- Set up the string formats for my arguments
    local arg_str = "{ind}   %s - {desc%d}"
    local def_arg = "{ind}   %s - {desc%d} (default value: %%s)"
    local typ_arg = "{ind}   %s: %%s - {desc%d}"
    local t_d_arg = "{ind}   %s: %%s - {desc%d} (default value: {default})"

    -- Set up the partial strings as well
    local def_str_partial = ""
    local typ_str_partial = ""
    local t_d_str_partial = ""

    -- Initialise the list of strings to append in the end:
    local format_arg_strings = {}
    local arguments = {}

    -- Set up default values for string replacement
    local function_name = "my_func"
    local return_type = "none"

    local num_args = 1
    for id, capture in query:iter_captures(node) do
        local name = query.captures[id]
        local text = vim.treesitter.get_node_text(capture, 0)

        if name == "function.name" then
            function_name = text
        end
        if name == "function.return_type" then
            return_type = text
        end

        -- Handle normal arguments
        if name == "param.name" then
            local str = string.format(arg_str, text, num_args)
            table.insert(format_arg_strings, str)
            arguments["desc" .. num_args] = i(num_args + 1, "<Arg" .. num_args .. " description>")
            num_args = num_args + 1
        end

        -- Handle arguments with default value
        if name == "def_param.name" then
            def_str_partial = string.format(def_arg, text, num_args)
        elseif name == "def_param.default" then
            local str = string.format(def_str_partial, text)
            table.insert(format_arg_strings, str)
            arguments["desc" .. num_args] = i(num_args + 1, "<Arg" .. num_args .. " description>")
            num_args = num_args + 1
        end

        -- Handle arguments with a type
        if name == "typ_param.name" then
            typ_str_partial = string.format(typ_arg, text, num_args)
        elseif name == "typ_param.type" then
            local str = string.format(typ_str_partial, text)
            table.insert(format_arg_strings, str)
            arguments["desc" .. num_args] = i(num_args + 1, "<Arg" .. num_args .. " description>")
            num_args = num_args + 1
        end

        -- Handle arguments with a type and default value
        if name == "typ_def_param.name" then
            t_d_str_partial = string.format(t_d_arg, text, num_args)
        elseif name == "typ_def_param.type" then
            t_d_str_partial = string.format(t_d_str_partial, text)
        elseif name == "typ_def_param.default" then
            local str = t_d_str_partial:gsub("{default}", text)
            table.insert(format_arg_strings, str)
            arguments["desc" .. num_args] = i(num_args + 1, "<Arg" .. num_args .. " description>")
            num_args = num_args + 1
        end
    end
    header = string.format(header, function_name)
    footer = string.format(footer, return_type)

    local return_string_list = { header }
    for _, line in ipairs(format_arg_strings) do
        table.insert(return_string_list, line)
    end
    table.insert(return_string_list, footer)
    local return_string = table.concat(return_string_list, "\n")

    return return_string, arguments
end

local treesitter_docstring_handler = {
    full = function(query, node, indent)
        local format, arguments = parse_python_query(query, node)
        arguments['func_desc'] = i(1, "<Function description>")
        arguments['ind'] = t(indent)
        return sn(nil, fmt(format, arguments), {
            node_ext_opts = {
                active = {
                    virt_text = { { "<- Option: full docstring", "GruvboxOrange" } }
                }
            }
        })
    end,
    timestamp = function(query, node, indent)
        local time = curtime()
        local format, arguments = parse_python_query(query, node, time)
        arguments['func_desc'] = i(1, "<Function description>")
        arguments['ind'] = t(indent)
        return sn(nil, fmt(format, arguments), {
            node_ext_opts = {
                active = {
                    virt_text = { { "<- Option: docstring with timestamp", "GruvboxOrange" } }
                }
            }
        })
    end,
    simple = function(query, node, indent)
        for _, capture in query:iter_captures(node, 0) do
            if capture:type() == "identifier" then
                return sn(nil, fmt([[
"""
{ind}Function: {func_name}  {func_desc}
{ind}"""
]], {
                    func_name = f(function() return vim.inspect(capture:type()) end),
                    func_desc = i(1, "<Function description>"),
                    ind = t(indent)
                }), {
                    node_ext_opts = {
                        active = {
                            virt_text = { { "<- Option: simple docstring" } }
                        }
                    }
                })
            end
        end
    end,
    no = function(_, _, _)
        return t("", {
            node_ext_opts = {
                active = {
                    virt_text = { { "<- Option: no docstring", "GruvboxOrange" } }
                }
            }
        })
    end
}

local function treesitter_python_create_docstring(template)
    return function(snip)
        local indent = snip and snip.env.TM_CURRENT_LINE:match("^%s*") and not "" or "\t"
        local function_node_types = {
            function_definition = true,
        }

        -- Find the first function node that is a parent of the cursor
        local node = vim.treesitter.get_node()
        while node ~= nil do
            if function_node_types[node:type()] then
                break
            end
            node = node:parent()
        end

        -- Exit if no match
        if not node then
            -- vim.notify("Treesitter Error: Not inside a function.")
            return sn(nil, {
                t('"""'),
                i(1, "Placeholder description"),
                t('"""')
            })
        end

        local query = assert(vim.treesitter.query.get(
            "python", "python_function_description"
        ), "No query")

        if treesitter_docstring_handler[template] then
            local handler = treesitter_docstring_handler[template]
            return handler(query, node, indent)
        end

        return sn(nil, { r(1, "Function not found") })
    end
end

local python_docstring_full = treesitter_python_create_docstring('full')
local python_docstring_timestamp = treesitter_python_create_docstring('timestamp')
local python_docstring_simple = treesitter_python_create_docstring('simple')
local python_no_docstring = treesitter_python_create_docstring('no')

local function python_docstring(snip)
    return sn(nil, {
        c(1, {
            python_docstring_full(snip),
            python_docstring_timestamp(snip),
            python_docstring_simple(snip),
            python_no_docstring(snip),
        })
    })
end


-- ls.parse.parse_snippet(<text>, <VSCode style snippet>)
ls.add_snippets("all", {
})

-- python snippets
ls.add_snippets("python", {
    -- create a python function definition with automated docstring
    s("def", fmt([[
        def {func}({args}){ret}:
            {doc}
            {body}
    ]], {
        func = i(1, "my_func"),
        args = i(2, "arg: type"),
        -- ret = i(3, "return type"),
        ret = isn(3, { c(1, {
            t('', {
                node_ext_opts = {
                    active = {
                        virt_text = { { "<- Option: no return type", "GruvboxOrange" } }
                    }
                }
            }),
            sn(nil, {
                t(' -> '),
                i(1, "return_type")
            }, {
                node_ext_opts = {
                    active = {
                        virt_text = { { "<- Option: specify return type", "GruvboxOrange" } }
                    }
                }
            }),
        }) }, "$PARENT_INDENT\t"),
        -- doc = i(4, "doc"),
        doc = d(4, function(_, snip)
            return python_docstring(snip)
        end, { 1, 2, 3 }),
        body = i(0),
    })),
    s("docstring", fmt([[
    """
    {doc}
    """
        ]], {
        doc = i(1, "<docstring>")
    })),
})


-- lua snippets
ls.add_snippets("lua", {
    ls.parser.parse_snippet("local function", "local function $1($2)\n    $0\n end"),
    s("req",
        fmt([[local {} = require("{}")]], {
            f(function(import_name)
                local parts = vim.split(import_name[1][1], ".", { plain = true })
                return parts[#parts] or ""
            end, { 1 }),
            i(1)
        })
    ),
})
