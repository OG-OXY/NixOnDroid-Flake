return {
  "nvim-neorg/neorg",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neorg/lua-utils.nvim",
    "pysan3/pathlib.nvim",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    require("neorg").setup {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/sdcard/Documents/norg/notes",
            },
            default_workspace = "notes",
          },
        },
        ["core.keybinds"] = {
          config = {
            default_keybinds = false,
          },
        },
      },
    }
  end,
}
