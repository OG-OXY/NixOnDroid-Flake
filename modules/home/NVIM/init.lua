-- Set leader key early
vim.g.mapleader = " "
-- Boot the plugin manager
require("config.lazy")
-- Load your basic options
vim.opt.number = true
vim.opt.relativenumber = true

