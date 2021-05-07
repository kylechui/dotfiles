require'bufferline'.setup{}
vim.g.nvim_tree_width=36
vim.g.nvim_tree_follow=1


local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
  ["."] = tree_cb("toggle_dotfiles"),
  ["n"] = tree_cb("create"),
  ["r"] = tree_cb("full_rename"),
  ["<"] = tree_cb("dir_up"),
} 
