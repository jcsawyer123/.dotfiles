-- Window/split navigation
return {
    -- Split navigation
    { 'n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' }},
    { 'n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' }},
    { 'n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' }},
    { 'n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' }},
    
    -- Split creation/resizing (VSCode-like)
    { 'n', '<C-\\>', '<cmd>vsplit<CR>', { desc = 'Split vertically' }},
    { 'n', '<C-_>', '<cmd>split<CR>', { desc = 'Split horizontally' }},
    { 'n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' }},
    { 'n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' }},

    -- Buffer navigation
    { 'n', '<Tab>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' }},
    { 'n', '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' }},
    { 'n', '<leader>x', '<cmd>bdelete<CR>', { desc = 'Close buffer' }},
    
    -- Buffer reordering
    { 'n', '<leader>bl', '<cmd>BufferLineMoveNext<CR>', { desc = 'Move buffer right' }},
    { 'n', '<leader>bh', '<cmd>BufferLineMovePrev<CR>', { desc = 'Move buffer left' }},
  }