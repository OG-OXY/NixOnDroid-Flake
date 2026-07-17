{
  description = "AstroNvim Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    astrovim = {
      url = "github:AstroNvim/template";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, astrovim, ... } @ inputs:
  let
    system = "aarch64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    packages.${system}.nix-on-droid = pkgs.symlinkJoin {
      name = "AstroNvim";
      paths = [ astrovim self ];
    };
  };
}
