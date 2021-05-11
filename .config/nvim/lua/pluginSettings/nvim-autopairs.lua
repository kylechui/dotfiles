-- Don't spawn a matching delimiter if cursor precedes alphanumeric character
require('nvim-autopairs').setup({ ignored_next_char = "[%w]"})
local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')

-- I already have an UltiSnips macro for this
npairs.remove_rule('"', {"tex", "latex"})
