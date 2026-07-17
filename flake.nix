{
  description = "Basic example of Nix-on-Droid system config.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #nixCats.url = "path:./flakes/nixCats";
    #nvf.url = "path:./flakes/NVF";
    #nixvim = {
    #  url = "github:nix-community/nixvim";
      #inputs.nixpkgs.follows = "nixpkgs";
    #};
    #astronvim = {
      #url = "path:./flakes/AstroNvim";
      #inputs.nixpkgs.follows = "nixpkgs";
    #};
    #herdr.url = "path:./flakes/LLM-Agents_Herdr/";
  };

  outputs = { self, nixpkgs, nix-on-droid, home-manager,  ... }@inputs: {

    nixOnDroidConfigurations.nix-on-droid = nix-on-droid.lib.nixOnDroidConfiguration {
      pkgs = import nixpkgs {
        system = "aarch64-linux";
        config.allowUnfree = true;
	      overlays = [
	        (final: prev: {
	          astronvim-src = inputs.astronvim;
	        })
	      ];
      };
      extraSpecialArgs = { 
        inherit self inputs;
        nvf-pkg = inputs.nvf.packages.aarch64-linux.default;
        herdr = inputs.herdr.packages.aarch64-linux.default;
      };
      modules = [
        ./nix-on-droid.nix
	      {
         home-manager = {
           useGlobalPkgs = true;
           useUserPackages = true;
           backupFileExtension = "backup";
           config = ./home.nix;
	         extraSpecialArgs = { 
	           inherit self inputs;
	           herdr = inputs.herdr.packages.aarch64-linux.default;
	         };
	         sharedModules = [
	           #inputs.nixCats.homeModule
	           #inputs.nixvim.homeModules.nixvim 
	         ];
         };
        }
      ];
    };
  };
}
