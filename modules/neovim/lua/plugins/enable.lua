require("leap").create_default_mappings()
require("Comment").setup { pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook() }
require("nvim-surround").setup {}
require("ts_context_commentstring").setup {}
require("oil").setup {}
