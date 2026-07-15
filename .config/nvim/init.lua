vim.cmd([[
    call plug#begin()
    Plug 'EdenEast/nightfox.nvim'
    Plug 'lervag/vimtex'
    Plug 'lervag/vimtex', { 'tag': 'v2.15' }
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'JuliaEditorSupport/julia-vim'
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
map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "find files" })
map("n", "<leader>sp", "<cmd>Telescope live_grep<cr>", { desc = "live grep" })
map("n", "<leader>,", "<cmd>Telescope buffers<cr>", { desc = "buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "help tags" })
-- Ctrl-j Ctrl-k movement inside Telescope picker.
require("telescope").setup({
  defaults = {
    mappings = {
      i = { -- insert mode (default mode when the picker opens)
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
      },
    },
  },
})
