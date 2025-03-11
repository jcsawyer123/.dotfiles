-- Editor operations
return {
    -- Quick escape using 'jj'
    { 'i', 'jj', '<Esc>', { desc = 'Exit insert mode', noremap = true }},

    -- Search
    { 'n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' }},
    
    -- Line operations
    { 'n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' }},
    { 'n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' }},
    
    -- Multi-cursor like operations
    { 'n', '<C-d>', '*``cgn', { desc = 'Change next occurrence' }},
    
    -- Comments (requires Comment.nvim)
    { 'n', '<C-/>', 'gcc', { desc = 'Toggle line comment' }},
    { 'v', '<C-/>', 'gc', { desc = 'Toggle visual comment' }},
  }