require("nvim-surround").setup {}
require("nvim-ts-autotag").setup {}
require("ts_context_commentstring").setup {}
require("Comment").setup {
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
}
