return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    servers = {
      "nil_ls",   -- Nix
      "lua_ls",   -- Lua
      "jsonls",   -- JSON/JSONC
      "cssls",    -- CSS
      "marksman", -- Markdown
    },
  },
}
