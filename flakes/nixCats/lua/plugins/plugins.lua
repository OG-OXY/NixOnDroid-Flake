require('gitsigns').setup()
require('Comment').setup()
require('todo-comments').setup()

require('bufferline').setup({
  options = {
    diagnostics = "nvim_lsp",
    offsets = { { filetype = "yazi", text = "File Manager", padding = 1 } }
  }
})

require('lualine').setup({ options = { theme = 'gruvbox' } })
require('alpha').setup(require('alpha.themes.dashboard').config)
require('indent_blankline').setup()

require('blink.cmp').setup({
  snippets = { preset = 'default' },
  sources = { default = { 'lsp', 'path', 'buffer', 'snippets' } },
  keymap = { preset = 'default' }
})

-- LSP Configs
local lspconfig = require('lspconfig')

lspconfig.nixd.setup({
  settings = {
    formatting = {
      command = { "nixfmt" }
    }
  }
})
lspconfig.ts_ls.setup({})
lspconfig.lua_ls.setup({})

-- Conform Auto-format
require('conform').setup({
  formatters_by_ft = {
    nix = { "nixfmt" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

-- Neorg
require('neorg').setup({
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/Documents/neorg/notes"
        }
      }
    }
  }
})
