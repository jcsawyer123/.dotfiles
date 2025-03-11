-- keymaps.lua
local function load_keymaps(keymaps)
  for _, keymap in ipairs(keymaps) do
    vim.keymap.set(keymap[1], keymap[2], keymap[3], keymap[4])
  end
end

-- Load all custom keymaps
for _, keymaps_module in ipairs(require("custom.keymaps")) do
  load_keymaps(keymaps_module)
end

-- Keep your autocommands here
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


-- vim: ts=2 sts=2 sw=2 et
