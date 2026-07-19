-- Customize Treesitter
-- --------------------
-- Treesitter customizations are handled with AstroCore
-- as nvim-treesitter simply provides a download utility for parsers

---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      treesitter = {
        lazy = false,
        highlight = true, -- enable/disable treesitter based highlighting
        indent = true, -- enable/disable treesitter based indentation
        auto_install = false, -- enable/disable automatic installation of detected languages
        --ensure_installed = {
        --  "vim",
        --  "lua",
        --  "python",
        --  "nix",
        --  "json",
        --  "css",
        --  "lemminx",
        --  "norg",
        --  "norg_meta",
        --  "markdown",
        --  "java",
        --},
      },
    },
  },
}
