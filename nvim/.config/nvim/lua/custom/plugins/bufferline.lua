return {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {
        options = {
          mode = 'buffers',
          separator_style = "",
          always_show_bufferline = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          color_icons = true,
          offsets = {
            {
              filetype = 'NvimTree',
              text = 'File Explorer',
              text_align = "left",
              highlight = 'Directory',
              separator = false,
              padding = 1,
              win_width = function()
                return require('nvim-tree.view').View.width
              end
            },
          },
        }
      }
    end,
  }