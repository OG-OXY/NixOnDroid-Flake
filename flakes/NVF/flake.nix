{
  description = "AstroNvim Replication Package using NVF";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, nvf, ... }:
    let
      system = "aarch64-linux";
      
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            vimPlugins = prev.vimPlugins.extend (self: super: {
              markdown-preview-nvim = super.markdown-preview-nvim.overrideAttrs (_: {
                dontUnpack = true;
                dontBuild = true;
              });
              nvim-lint = super.nvim-lint.overrideAttrs (_: {
                unpackPhase = "mkdir -p $out";
                dontUnpack = false;
                dontBuild = true;
              });
            });
          })
        ];
      };
      myNVF = nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [
          {
            config.vim = {
              viAlias = false;
              vimAlias = false;
              options = {
                shiftwidth = 2;
                tabstop = 2;
                expandtab = true;
                termguicolors = true;
                number = true;
                relativenumber = true;
                mouse = "a";
              };
              theme = {
                enable = true;
                name = "gruvbox";
                style = "dark";
                transparent = false;
              };
              statusline.lualine = {
                enable = true;
              };
              visuals = {
                nvim-web-devicons.enable = true;
                nvim-scrollbar.enable = true;
                cinnamon-nvim.enable = true;
                indent-blankline.enable = true;
                nvim-cursorline.enable = true;
              };
              dashboard.alpha.enable = true;
              filetree.neo-tree.enable = true;
              telescope.enable = true;
              # Core AstroNvim Utilities
              git = {
                enable = true;
                gitsigns.enable = true;
              };
              autopairs.nvim-autopairs.enable = true;
              utility.motion.hop.enable = true;
              binds.whichKey.enable = true;
              terminal.toggleterm = {
                enable = true;
                setupOpts.direction = "float";
              };
              tabline.nvimBufferline.enable = true;
              autocomplete.blink-cmp.enable = true;
              luaConfigPost = ''
                require('blink.cmp').setup({
                  snippets = {
                    preset = 'default'
                  }
                })
              '';
              snippets.luasnip.enable = false;
              keymaps = [
                { key = "<leader>e"; action = ":Neotree toggle<CR>"; mode = "n"; desc = "Toggle Explorer"; }
                { key = "<leader>ff"; action = ":Telescope find_files<CR>"; mode = "n"; desc = "Find Files"; }
                { key = "<leader>fw"; action = ":Telescope live_grep<CR>"; mode = "n"; desc = "Find Words"; }
                { key = "<leader>tf"; action = ":ToggleTerm<CR>"; mode = "n"; desc = "Toggle Floating Terminal"; }
                { key = "L"; action = ":BufferLineCycleNext<CR>"; mode = "n"; desc = "Next Buffer"; }
                { key = "H"; action = ":BufferLineCyclePrev<CR>"; mode = "n"; desc = "Previous Buffer"; }
                { key = "<leader>c"; action = ":bdelete<CR>"; mode = "n"; desc = "Close Buffer"; }
              ];
              lsp.enable = true;
              lsp.formatOnSave = true;
              languages = {
                enableTreesitter = true;
                enableFormat = true;
                enableExtraDiagnostics = true;
                nix.enable = true;
                fish.enable = true;
                bash.enable = true;
                toml.enable = true;
                markdown.enable = true;
                html.enable = true;
                css.enable = true;
                lua.enable = true;
              };
              notes = {
                neorg = {
                  enable = true;
                  setupOpts = {
                    workspaces = [
                      {
                        name = "notes";
                        path = "~/Documents/norg/notes";
                      }
                    ];
                  };
                };
              };
            };
          }
        ];
      };
    in
    {
      packages.${system}.default = myNVF.neovim.overrideAttrs (oldAttrs: {
        postInstall = (oldAttrs.postInstall or "") + ''
          mv $out/bin/nvim $out/bin/nvf
        '';
      });
    };
}
