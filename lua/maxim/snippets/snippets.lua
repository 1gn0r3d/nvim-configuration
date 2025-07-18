local ls = require("luasnip")
local types = require("luasnip.util.types")
require("luasnip.session.snippet_collection").clear_snippets("all")

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
    return f(function()
        return os.date("%D - %H:%M")
    end)
end


local function python_type(arg)
    if arg[1] == "" then
        return ""
    else
        local ret_type = vim.split(arg[1], " -> ", true)
        return ret_type[#ret_type]
    end
end

local function python_args_dyn(args)
    local arg_string = args[1] or ""
    local arg_list = vim.split(arg_string, ",", { trimempty = true })

    local nodes = {}
    local insert_index = 1

    for _, arg in ipairs(arg_list) do
        local a = vim.split(arg, "=", { trimempty = true })
        b = vim.split(a[1], ":", { trimempty = true })
        local description_string = "Description of " .. b[#b]

        local def = vim.split(arg, "=", { trimempty = true })

        if #def > 1 then
            description_string = description_string .. " (Default value: " .. def[#def] .. ")"
        end

        table.insert(nodes, t(a[1] .. "  - "))
        table.insert(nodes, i(insert_index, description_string))
        table.insert(nodes, t({ "", "" }))
        insert_index = insert_index + 1
    end
    -- print(vim.inspect(nodes))
    return isn(nil, nodes, "$PARENT_INDENT\t   ")
end


local function create_function_description(args, time_entry)
    local format_string_table = { '"""' }
    local time = time_entry or ""
    if time ~= "" then
        time = time .. "\n\t"
    end
    local arg_string = args[1] or ""
    local arg_list = vim.split(arg_string, ",", { trimempty = true })

    table.insert(format_string_table, time)
    table.insert(format_string_table, [[{fname} - {desc}

    Args:
        {args}
        ]])
    -- print(vim.inspect(arg_list))
    for ind, a in ipairs(arg_list) do
        -- print(vim.inspect(a))
        -- table.insert(format_string_table, "{arg" .. ind .. "}")
    end
    table.insert(format_string_table, [[

    Returns:
        {returns}
"""
    ]])

    return table.concat(format_string_table)
end


-- ls.parse.parse_snippet(<text>, <VSCode style snippet>)
ls.add_snippets("all", {
})

-- python snippets
ls.add_snippets("python", {
    -- create a python function definition with automated docstring
    s({ trig = "def_function", desc = "Snippet to define a python function." }, fmt([[
        def {func}({args}){ret}:
            {doc}
            {body}
    ]], {
        func = i(1, "my_func"),
        args = i(2, "arg: type"),
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
        doc = d(4, function(args)
            local func_name = args[1][1]
            local arg_list = args[2]
            local ret_type = args[3]

            -- print("arg list: " .. vim.inspect(arg_list))

            local docstring_choices = {
                sn(nil, fmt(create_function_description(arg_list), {
                    fname = t(func_name),
                    desc = r(1, "Function description."),
                    -- args = sn(nil, t(arg_list)),
                    args = python_args_dyn(arg_list),
                    returns = python_type(ret_type),
                }), {
                    node_ext_opts = {
                        active = {
                            virt_text = { { "<- Option: full docstring", "GruvboxOrange" } }
                        }
                    }
                }),
                sn(nil, fmt(create_function_description(arg_list, "Created on {time} - Maxim Vanrusselt"), {
                    time = curtime(),
                    fname = t(func_name),
                    desc = r(1, "Function description."),
                    args = sn(nil, t(arg_list)),
                    returns = python_type(ret_type),
                }), {
                    node_ext_opts = {
                        active = {
                            virt_text = { { "<- Option: full docstring with author", "GruvboxOrange" } }
                        }
                    }
                }),
                sn(nil, fmt([["""{desc}"""]], {
                    desc = r(1, "Function description.")
                }), {
                    node_ext_opts = {
                        active = {
                            virt_text = { { "<- Option: short description", "GruvboxOrange" } }
                        }
                    }
                }),
                t("", {
                    node_ext_opts = {
                        active = {
                            virt_text = { { "<- Option: no docstring", "GruvboxOrange" } }
                        }
                    }
                }),
            }

            return isn(nil, {
                c(1, docstring_choices)
            }, "$PARENT_INDENT\t")
        end, { 1, 2, 3 }),
        body = i(0),
    }
    )),
})


-- lua snippets
ls.add_snippets("lua", {
    ls.parser.parse_snippet("local function", "local $1 = function($2)\n    $0\n end"),
    s("req",
        fmt([[local {} = require("{}")]], {
            f(function(import_name)
                local parts = vim.split(import_name[1][1], ".", true)
                return parts[#parts] or ""
            end, { 1 }),
            i(1)
        })
    ),
})
