local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- (Auto-installation logic goes here if you want it)
require("lazy").setup({
  spec = {
    { import = "plugins" }, -- Tells Lazy to look in lua/plugins/ for all files
  },
})

