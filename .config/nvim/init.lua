vim.cmd([[
    call plug#begin()
    Plug 'EdenEast/nightfox.nvim'
    Plug 'lervag/vimtex'
    Plug 'lervag/vimtex', { 'tag': 'v2.15' }
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    call plug#end()
]])
vim.g.mapleader = " "
vim.keymap.set("i", "jk", "<ESC>")
vim.cmd("colorscheme nightfox")
vim.cmd("set relativenumber")
vim.cmd("set clipboard=unnamedplus")
vim.cmd("set shiftwidth=4")
vim.cmd("set wrap")
vim.cmd("set linebreak")

local map = vim.keymap.set
map("i", "<C-a>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "help tags" })
