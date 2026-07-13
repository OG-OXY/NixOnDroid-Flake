{ config, pkgs, lib, inputs, ... }:

{
  home.file.".config/herdr/config.toml".text = ''
    default_shell = "/data/data/com.termux.nix/files/home/.nix-profile/bin/fish"
    # prefix = "C-b"
  '';
}

