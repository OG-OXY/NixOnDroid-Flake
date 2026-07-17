return {
  "nvim-neorg/neorg",
  lazy = false, -- Load on startup so autocommands register instantly
  version = "*", -- Pin to the latest stable release
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("neorg").setup {
      load = {
        ["core.defaults"] = {}, -- Loads baseline functionality
        ["core.conceal"] = {},  -- Enables beautiful icons/folding for headings & lists
        ["core.dirman"] = {     -- Manages your workspaces
          config = {
            workspaces = {
              notes = "~/Documents/notes/norg", -- Raw .norg files live here
            },
            default_workspace = "notes",
          },
        },
        ["core.export"] = {},
        ["core.export.markdown"] = {
          config = {
            extensions = "all", -- Carry over metadata, tasks, and blocks
          },
        },
      },
    }

    -- AUTOMATION: Compile to Markdown on save for Syncthing
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.norg",
      callback = function()
        local current_file = vim.api.nvim_buf_get_name(0)
        
        -- Source directory vs your Syncthing deployment directory
        local norg_dir = vim.fn.expand("~/Documents/notes/norg/")
        local sync_dir = vim.fn.expand("~/Documents/notes/sync_vault/")

        -- Calculate subfolders so directory hierarchies stay matching
        local relative_path = current_file:sub(#norg_dir + 1)
        local target_md_path = sync_dir .. relative_path:gsub("%.norg$", ".md")

        -- Generate directory paths if they don't exist yet
        local target_dir = vim.fn.fnamemodify(target_md_path, ":h")
        if vim.fn.isdirectory(target_dir) == 0 then
          vim.fn.mkdir(target_dir, "p")
        end

        -- Run the translation module silently
        vim.cmd("silent Neorg export to-file " .. vim.fn.fnameescape(target_md_path))
      end,
    })
  end,
}

