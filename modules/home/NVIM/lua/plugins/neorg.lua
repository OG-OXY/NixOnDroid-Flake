return {
  "nvim-neorg/neorg",
  -- CRITICAL: This prevents Neovim from trying to compile on Android/Nix-on-Droid
  build = false, 
  dependencies = { 
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {}, -- Loads default modules
        ["core.norg.concealer"] = {}, -- Makes it look nice
        ["core.norg.dirman"] = { -- Manages your notes
          config = {
            workspaces = {
              notes = "~/Documents/norg/notes", -- Make sure this directory exists on your device
            },
          },
        },
      },
    })
  end,
}

