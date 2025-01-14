return {
    "dnlhc/glance.nvim",
    config = function()
      local glance = require('glance')
      local actions = glance.actions
  
      glance.setup({
        border = {
          enable = true,
        },
        preview_win_opts = {
          cursorline = true,
          number = true,
          wrap = true,
        },
        theme = {
          enable = true,
          mode = 'auto',
        },
        mappings = {
          list = {
            ['j'] = actions.next,     -- Next item
            ['k'] = actions.previous, -- Previous item
            ['<Tab>'] = actions.enter_win('preview'), -- Focus preview window
            ['q'] = actions.close,
            ['<ESC>'] = actions.close,
            ['<CR>'] = actions.jump,    -- Jump to location
          },
          preview = {
            ['q'] = actions.close,
            ['<Tab>'] = actions.enter_win('list'), -- Focus list window
            ['<ESC>'] = actions.enter_win('list'),
          },
        },
      })
  
      -- Peek keymaps
      vim.keymap.set('n', 'gpd', '<CMD>Glance definitions<CR>', { desc = 'Peek definition' })
      vim.keymap.set('n', 'gpr', '<CMD>Glance references<CR>', { desc = 'Peek references' })
      vim.keymap.set('n', 'gpi', '<CMD>Glance implementations<CR>', { desc = 'Peek implementation' })
      vim.keymap.set('n', 'gpt', '<CMD>Glance type_definitions<CR>', { desc = 'Peek type definition' })
    end,
  }