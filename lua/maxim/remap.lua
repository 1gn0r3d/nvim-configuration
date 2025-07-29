vim.g.mapleader = " "
vim.g.maplocalleader = ' '
-- vim.api.nvim_set_keymap("n", "<C-i>", "<C-i>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Tab>", "<Cmd>bnext<CR>", { noremap = true, silent = true })
-- keymap for :Ex depreciated by Oil.nvim plugin
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = 'Project view' })

-- Saving and quitting
vim.keymap.set("n", "<leader>w", "<CMD>update<CR>", { desc = "Save file." })
-- vim.keymap.set("n", "<leader>w", "<CMD>w<CR>", { desc = "Save file." })
vim.keymap.set("n", "<leader>qq", "<CMD>qa!<CR>", { desc = "Quit all." })
vim.keymap.set("n", "<leader>wq", "<CMD>wqa!<CR>", { desc = "Save and quit all." })
vim.keymap.set("n", "<leader>q", "<CMD>q!<CR>",
    { noremap = true, silent = true, desc = "Close current window without saving." })
vim.keymap.set("n", "<C-q>", "<CMD>q!<CR>",
    { noremap = true, silent = true, desc = "Close current window without saving." })

-- Remap esc to ctrl+c
vim.keymap.set({ "i", "v" }, "<C-c>", "<Esc>", { desc = "Remap ctrl+c to esc." })

-- Move lines up and down using J and K in visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>`<gv", { desc = "Move selected line up." })
vim.keymap.set("v", "J", ":m '>+1<CR>`<gv", { desc = "Move selected line down." })

-- indent and outdent lines quickly
vim.keymap.set('n', '<TAB>', '>>', { desc = "Indent selected lines." })
vim.keymap.set('n', '<S-TAB>', '<<', { desc = "Outdent selected lines." })

-- indent and outdent lines in visual mode
vim.keymap.set('v', '<TAB>', '<S->>gv', { desc = "Indent selected lines." })
vim.keymap.set('v', '<S-TAB>', '<S-<>gv', { desc = "Outdent selected lines." })

-- Append next line to previous line using J in normal mode without moving the cursor
vim.keymap.set("n", "J", "mzJ`z", { desc = "Append next line to previous line." }) -- use ctrl+d and ctrl+u to scroll one third of the window while keeping the cursor centered

-- Turn off highlights after search
vim.keymap.set("n", "<leader>hl", "<CMD>noh<CR><CR>", { desc = "Remove search highlights." })

local function scroll(direction)
    local height = vim.api.nvim_win_get_height(0)
    local third = math.floor(height / 3)
    -- print("height: ", height)
    -- print(third)
    vim.cmd("normal!" .. third .. direction .. "zz")
end
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", function()
    scroll('j')
end, { desc = "Scroll 1/3rd page down.", noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", function()
    scroll('k')
end, { desc = "Scroll 1/3rd page down.", noremap = true, silent = true })

-- use n and N in normal mode for searching?
vim.keymap.set("n", "n", "nzzzv", { desc = "Navigate search results." })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Navigate search results." })

-- greatest remap ever
--      it deletes the selected text
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Pastes without yanking selected text." })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copies selection to system clipboard." })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copies entire line to system clipboard." })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Deletes without yanking text." })

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format code layout." })

-- go to errors in quick fix list??
vim.keymap.set("n", "<leader>k", "<cmd>cnext<CR>zz", { desc = "Go to next item in quickfix list." })
vim.keymap.set("n", "<leader>j", "<cmd>cprev<CR>zz", { desc = "Go to previous item in quickfix list." })
vim.keymap.set("n", "<leader>K", "<cmd>lnext<CR>zz", { desc = "Go to next item in location list." })
vim.keymap.set("n", "<leader>J", "<cmd>lprev<CR>zz", { desc = "Go to previous item in location list." })

vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Search and replace the word under the cursor globally in the current file." })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>",
    { silent = true, desc = "Make the current file executable. (Linux)" })

vim.keymap.set("n", "<leader>cm", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "~~ MAKE IT RAIN! ~~" })
vim.keymap.set("n", "<leader>cg", "<cmd>CellularAutomaton game_of_life<CR>", { desc = "~~ Game of life! ~~" })
vim.keymap.set("n", "<leader>cs", "<cmd>CellularAutomaton scramble<CR>", { desc = "~~ Scramble! ~~" })

-- remaps for creating horizontal and vertical splits (partially taken over by windowcolumn.nvim)
vim.keymap.set("n", "<leader>sh", "<CMD>split<CR>", { noremap = true, silent = true, desc = "Create horizontal split." })
-- vim.keymap.set("n", "<leader>s", "<CMD>vsplit<CR>", { noremap = true, silent = true, desc = "Create vertical split." })

-- remaps for navigating horizontal and vertical splits
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Navigate to left split." })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Navigate to down split." })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Navigate to up split." })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Navigate to right split." })

-- terminal settings
vim.keymap.set('t', '<Esc>', "<C-\\><C-n>", { desc = "Exit terminal." })

-- minimise terminal split
vim.keymap.set('n', '<C-g>', "3<C-w>_", { desc = "Minimise terminal split." })

-- go back after jumping:
vim.keymap.set('n', 'gs', '<C-o>', { desc = "Go back after jumping." })

-- insert an enter at cursor from normal mode
-- vim.keymap.set('n', '<C-i>', 'i<CR><Esc>', { desc = "Insert a newline from normal mode at cursor." })

-- python specific keymaps are initialised in an autocommand in init.lua
