local map = vim.api.nvim_set_keymap
-- Set up <Space> to be the global leader
map('n', '<Space>', '<NOP>', { noremap = true, silent = true })
vim.g.mapleader = ' '
-- Keybinds for editing and sourcing init files
map('n', '<Leader>s', '<Cmd>lua require(\'pluginSettings.telescope\').search_dotfiles()<CR>', { noremap = true, silent = true })
map('n', '<Leader>r', '<Cmd>luafile ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })
-- Saving files with <C-s>
map('n', '<C-s>', '<Cmd>up!<CR>', { noremap = true, silent = true })
map('i', '<C-s>', '<Esc><Cmd>up!<CR>', { noremap = true, silent = true })
map('v', '<C-s>', '<Esc><Cmd>up!<CR>', { noremap = true, silent = true })
-- Deleting words with <C-BS>
map('i', '', '<C-w>', { noremap = true, silent = true })
-- Open/close file explorer
map('n', '<C-\\>', '<Esc><Cmd>NvimTreeToggle<CR>', { noremap = true, silent = true })
-- Move towards the beginning/end of a line
map('n', 'H', 'g0', { noremap = true, silent = true })
map('v', 'H', 'g0', { noremap = true, silent = true })
map('n', 'L', 'g_', { noremap = true, silent = true })
map('v', 'L', 'g_', { noremap = true, silent = true })
-- Indent/dedent blocks fo text
map('v', '>', '>gv', { noremap = true, silent = true })
map('v', '<', '<gv', { noremap = true, silent = true })
-- Make Y actually make sense
map('n', 'Y', 'y$', { noremap = true, silent = true })
-- Better buffer navigation/deletion
map('n', '<Leader>j', '<Cmd>bn<CR>', { noremap = true, silent = true })
map('n', '<Leader>k', '<Cmd>bp<CR>', { noremap = true, silent = true })
map('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
map('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
map('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
map('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
map('n', '<C-w>', '<Cmd>bd!<CR>', { noremap = true, silent = true })
map('i', '<C-w>', '<Cmd>bd!<CR>', { noremap = true, silent = true })
-- Telescope fuzzy find stuff
map('n', '<Leader>ff', '<Cmd>lua require(\'pluginSettings.telescope\').search_workspace()<CR>', { noremap = true, silent = true })
map('n', '<Leader>fb', '<Cmd>lua require(\'telescope.builtin\').buffers()<CR>', { noremap = true, silent = true })
map('n', '<Leader>fg', '<Cmd>lua require(\'telescope.builtin\').live_grep()<CR>', { noremap = true, silent = true })
map('n', '<Leader>fh', '<Cmd>lua require(\'telescope.builtin\').help_tags()<CR>', { noremap = true, silent = true })
-- Moving lines up and down
map('n', 'J', '<Cmd>m+<CR>', { noremap = true, silent = true })
map('v', 'J', ':m \'>+1<CR>gv', { noremap = true, silent = true })
map('n', 'K', '<Cmd>m-2<CR>', { noremap = true, silent = true })
map('v', 'K', ':m \'<-2<CR>gv', { noremap = true, silent = true })
-- Commenting things out with <C-/>
map('n', '', '<Cmd>Commentary<CR>', { noremap = true, silent = true })
map('v', '', ':Commentary<CR>gv', { noremap = true, silent = true })
-- Allow for repeating commands in visual mode
map('v', '.', ':normal.<CR>', { noremap = true, silent = true })
