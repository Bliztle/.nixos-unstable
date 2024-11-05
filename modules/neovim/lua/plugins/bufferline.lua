local bufferline = require("bufferline")
bufferline.setup {
    options = {
        --     numbers = "ordinal",
        --     number_style = "superscript",
        --     mappings = true,
        --     close_command = "bdelete! %d",
        --     right_mouse_command = "bdelete! %d",
        --     left_mouse_command = "buffer %d",
        --     middle_mouse_command = nil,
        --     indicator_icon = "▎",
        --     buffer_close_icon = "",
        --     modified_icon = "●",
        --     close_icon = "",
        --     left_trunc_marker = "",
        --     right_trunc_marker = "",
        --     name_formatter = nil,
        --     max_name_length = 18,
        --     max_prefix_length = 15,
        --     tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        offsets = {
            {
                filetype = "neo-tree",
                text = "File Explorer",
                text_align = "left"
            }
        },
        --     show_buffer_icons = true,
        --     show_buffer_close_icons = true,
        --     show_close_icon = true,
        --     show_tab_indicators = true,
        --     persist_buffer_sort = true,
        --     separator_style = "thin",
        --     enforce_regular_tabs = false,
        --     always_show_bufferline = true,
        --     sort_by = "extension"
    }
}

vim.keymap.set('n', '<A-1>', '<Cmd>BufferLineGoToBuffer 1<CR>', { noremap = true })
vim.keymap.set('n', '<A-2>', '<Cmd>BufferLineGoToBuffer 2<CR>', { noremap = true })
vim.keymap.set('n', '<A-3>', '<Cmd>BufferLineGoToBuffer 3<CR>', { noremap = true })
vim.keymap.set('n', '<A-4>', '<Cmd>BufferLineGoToBuffer 4<CR>', { noremap = true })
vim.keymap.set('n', '<A-5>', '<Cmd>BufferLineGoToBuffer 5<CR>', { noremap = true })
vim.keymap.set('n', '<A-6>', '<Cmd>BufferLineGoToBuffer 6<CR>', { noremap = true })
vim.keymap.set('n', '<A-7>', '<Cmd>BufferLineGoToBuffer 7<CR>', { noremap = true })
vim.keymap.set('n', '<A-8>', '<Cmd>BufferLineGoToBuffer 8<CR>', { noremap = true })
vim.keymap.set('n', '<A-9>', '<Cmd>BufferLineGoToBuffer 9<CR>', { noremap = true })
vim.keymap.set('n', '<A-0>', '<Cmd>BufferLineGoToBuffer 10<CR>', { noremap = true })

vim.keymap.set('n', '<A-h>', '<Cmd>BufferLineCyclePrev<CR>', { noremap = true })
vim.keymap.set('n', '<A-l>', '<Cmd>BufferLineCycleNext<CR>', { noremap = true })
vim.keymap.set('n', '<A-J>', '<Cmd>BufferLineClose<CR>', { noremap = true })
vim.keymap.set('n', '<A-H>', '<Cmd>BufferLineCloseLeft<CR>', { noremap = true })
vim.keymap.set('n', '<A-L>', '<Cmd>BufferLineCloseRight<CR>', { noremap = true })
