require('which-key').register {
  ['<leader>c'] = { 
    name = '[C]ode',
    _ = 'which_key_ignore'
  },
  ['<leader>d'] = {
    name = '[D]ocument',
    _ = 'which_key_ignore'
  },
  ['<leader>g'] = {
    name = '[G]it',
    _ = 'which_key_ignore' 
  },
  ['<leader>h'] = { 
    name = 'More git',
    _ = 'which_key_ignore' 
  },
  ['<leader>r'] = { 
    name = '[R]un | [R]ename',
    f = { '<cmd>RunFile<CR>', 'run [F]ile' },
  },
  ['<leader>s'] = {
    name = '[S]earch',
    _ = 'which_key_ignore' 
  },
  ['<leader>w'] = {
    name = '[W]indow',
    _ = 'which_key_ignore' 
  },
  ['<leader>t'] = {
    name = '[T]erm',
    t = { '<cmd>ToggleTerm<CR>', '[T]oggle Term' },
  },
  ['<leader>f'] = {
    name = '[F]ile',
    e = { '<cmd>Telescope file_browser<CR>', '[E]xplorer' },
  },
  ['<leader>x'] = { '<cmd>bdelete<CR>', 'Delete current buffer' },
}

