local function open_jupyter_py_file(filename)
    local py_file = filename .. ".py"
    vim.cmd(":e " .. py_file)
    vim.cmd("normal! G$")
end

-- command to create a new jupyter notebook based on a template file
local function create_jupyter_notebook(notebookname)
    local config_path = vim.fn.stdpath('config')
    -- read the contents of the template file
    local template = config_path .. "/lua/maxim/jupyter_notebooks/template.ipynb"

    -- specify the new path for the notebook file
    local notebook_path = notebookname .. '.ipynb'

    -- copy the template
    local template_file = io.open(template, 'r')
    if not template_file then
        print("Error: Could not open template file at " .. template)
        return
    end
    local content = template_file:read("*a")
    template_file:close()

    local output_file = io.open(notebook_path, "w")
    if not output_file then
        print("Error: Could not open destination file at " .. notebook_path)
        return
    end
    output_file:write(content)
    output_file:close()

    -- run the jupytext command to hook the ipynb file to a py file
    local jupytext_command = "jupytext --set-formats ipynb,py:percent " .. notebookname .. '.ipynb'
    -- local Terminal = require('toggleterm.terminal').Terminal
    -- local term = Terminal:new({ cmd = jupytext_command, hidden = true })
    -- term:toggle()
    vim.fn.jobstart(jupytext_command, {
        on_stdout = function(_, data)
            open_jupyter_py_file(notebookname)
            --     if data then
            --         print(table.concat(data, '\n'))
            --     end
        end,
        -- on_stderr = function(_, data)
        --     if data then
        --         print(table.concat(data, "\n"))
        --     end
        -- end,
        -- on_exit = function(_, data)
        --     print("Jupytext command exited with code " .. data)
        --     open_jupyter_py_file(notebookname)
        -- end

    })
end


-- Create the custom neovim command to create the notebook file
vim.api.nvim_create_user_command(
    'CreateJupyterNotebook',
    function(opts)
        create_jupyter_notebook(opts.args)
    end,
    { nargs = 1 }
)
