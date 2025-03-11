return {
    require("custom.keymaps.navigation"),  -- window/split navigation
    require("custom.keymaps.files"),       -- file operations
    require("custom.keymaps.editor"),      -- editor features like search, yank, etc
    require("custom.keymaps.terminal"),    -- terminal related
    require("custom.keymaps.diagnostic"),  -- diagnostic/LSP related
  }