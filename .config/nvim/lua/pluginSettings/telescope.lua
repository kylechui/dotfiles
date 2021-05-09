local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
      },
    }
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}
require('telescope').load_extension('fzy_native')
local M = {}
M.search_dotfiles = function()
  require('telescope.builtin').find_files({
    prompt_title = 'Configuration files',
    cwd = '~/.config/nvim/',
  })
end

M.search_workspace = function()
  require('telescope.builtin').find_files({
    prompt_title = 'Workspace files',
    cwd = '~/Documents/github/',
  })
end
return M
