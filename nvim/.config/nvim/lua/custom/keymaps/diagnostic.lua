-- Diagnostic operations
return {
    { 'n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' }},
    { 'n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' }},
    { 'n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' }},
    { 'n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' }},
  }