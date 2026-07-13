{ config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    # Global Editor Settings (Your PC Vim Options)
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      smartindent = true;
      termguicolors = true;
    };

    # Keymaps block (clean and native)
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Yazi<cr>";
        options = { desc = "Open Yazi File Manager"; silent = true; };
      }
    ];

    # Your preferred theme
    colorschemes.gruvbox.enable = true;

    plugins = {
      # Syntax Highlighting Engine
      treesitter = {
        enable = true;
        settings.ensure_installed = [ "nix" "lua" "markdown" "javascript" "typescript" ];
      };

      # Native UI Improvements
      lualine.enable = true;
      telescope.enable = true;
      web-devicons.enable = true;
      yazi.enable = true; # Native yazi integration!

      # 1. BLINK-CMP (Bypasses Luasnip & Uses Native Neovim Snippets)
      blink-cmp = {
        enable = true;
        settings = {
          # Use Neovim 0.10+ native backend to skip external tar downloads entirely
          snippets.preset = "default"; 
          sources.default = [ "lsp" "path" "buffer" "snippets" ];
          keymap.preset = "default";
        };
      };

      # 2. LSP SETTINGS (Using nixd instead of nil)
      lsp = {
        enable = true;
        servers = {
          # The high-performance, official Nix LSP server
          nixd = {
            enable = true;
            settings = {
              # Provides auto-completions for your specific nixos configurations
              nixpkgs.expr = "import <nixpkgs> { }";
              formatting.command = [ "nixfmt" ];
            };
          };
          # Add any other required languages cleanly below
          ts_ls.enable = true; 
        };
      };

      # 3. EXPLICIT FORMATTING ENGINE (Using nixfmt)
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            nix = [ "nixfmt" ];
          };
          format_on_save = {
            timeout_ms = 500;
            lsp_format = "fallback";
          };
        };
      };
    };
  };
}
