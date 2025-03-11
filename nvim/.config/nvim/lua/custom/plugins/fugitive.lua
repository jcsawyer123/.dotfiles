return {
  'tpope/vim-fugitive',
  cmd = { 'G', 'Git' },
  keys = {
    { '<leader>gg', ':Git<CR>', desc = 'Git status' },
    { '<leader>gb', ':Git blame<CR>', desc = 'Git blame' },
  },
}
