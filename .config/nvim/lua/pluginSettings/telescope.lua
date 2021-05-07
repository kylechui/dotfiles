local M = {}
M.search_dotfiles = function()
  require('telescope.builtin').find_files({
    prompt_title = 'Configuration files',
    cwd = '~/.config/nvim/',
  })
end

M.search_workspace = function()
  require('telescope.builtin').find_files({
    prompt_title = 'Configuration files',
    cwd = '~/Documents/github/',
  })
end
return M

