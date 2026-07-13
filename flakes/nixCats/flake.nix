{
  description = "Ty's Standalone nixCats Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };

  outputs = { self, nixpkgs, nixCats, ... }@inputs:
    let
      inherit (nixCats) utils;
      luaPath = ./.;
      # Define your target systems
      systems = [ "aarch64-linux" "x86_64-linux" ];

      # Category definitions must be attribute sets
      categoryDefinitions = { pkgs, settings, categories, extra, ... }@packageDef: {
        startupPlugins = {
          generalBuildInputs = with pkgs.vimPlugins; [
            (alpha-nvim.overrideAttrs {
              dontUnpack = true;
              dontBuild = true;
            })
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
        };

        environmentPackages = {
          generalBuildInputs = with pkgs; [
            nixd
            nixfmt
            nodePackages.typescript-language-server
            lua-language-server
            yazi
          ];
        };
      };

      packageDefinitions = {
        nixcats = { pkgs, ... }: {
          settings = {
            wrapRc = true;
            aliases = [ "nvim" ];
          };
          categories = {
            generalBuildInputs = true;
          };
        };
      };
    in
    utils.eachSystem systems (system:
      let
        nixCatsBuilder = utils.baseBuilder luaPath {
          inherit nixpkgs system;
        } categoryDefinitions packageDefinitions;
      in
      {
        packages.default = nixCatsBuilder "nixcats";
      }
    );
}

