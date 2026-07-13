{ pkgs, config, ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos";
	type = "builtin";
      };
      display = {
        separator = " ➜ ";
      };
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "display"
        "cpu"
        "memory"
        "disk"
        "locale"
        "break"
        "colors"
      ];
    };
  };
}
