-- File operations
return {
    -- File explorer
    { 'n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true, desc = 'Toggle file explorer' }},
    
    -- File operations (when telescope is installed)
    { 'n', '<C-p>', '<cmd>Telescope find_files<CR>', { desc = 'Find files' }},
    { 'n', '<C-s>', '<cmd>w<CR>', { desc = 'Save file' }},

    -- Exit keymaps
    { 'n', '<leader>q', ':qa<CR>', { desc = 'Quit all (save session)' }},
    { 'n', '<leader>Q', ':qa!<CR>', { desc = 'Force quit all (no session save)' }},
    { 'n', '<leader>w', ':wqa<CR>', { desc = 'Save all and quit' }},
  }