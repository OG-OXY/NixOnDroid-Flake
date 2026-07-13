{ config, pkgs, inputs, ... }:

let
  # Build the package using the nixCats package builder directly
  myNeovim = inputs.nixCats.utils.mkNvimPackages inputs.nixCats {
    inherit pkgs;
  } {
    luaPath = ../nixCats;
    packageDefinitions = {
      nixcats = { pkgs, ... }: {
        settings = {
          wrapRc = true;
          aliases = [ "nvim" ];
        };
        categories = {
          generalBuildInputs = true;
          plugins = with pkgs.vimPlugins; [
            gruvbox-nvim
            lualine-nvim
            nvim-web-devicons
            alpha-nvim
            gitsigns-nvim
            comment-nvim
            indent-blankline-nvim
            todo-comments-nvim
            telescope-nvim
            yazi-nvim
            bufferline-nvim
            blink-cmp
            nvim-treesitter.withAllGrammars
            nvim-lspconfig
            conform-nvim
            neorg
          ];
          environmentPackages = with pkgs; [
            nixd
            nixfmt-rfc-style
            nodePackages.typescript-language-server
            lua-language-server
            yazi
          ];
        };
      };
    };
  };
in
{
  # Simply add your custom compiled neovim package to your home profile packages
  home.packages = [
    myNeovim.nixcats
  ];
}

