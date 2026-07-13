{ pkgs, config, lib, inputs, ... }: {
  
  # 1. State environment
  home.username = "nix-on-droid";
  home.homeDirectory = "/data/data/com.termux.nix/files/home";
  home.stateVersion = "25.11";
  imports = [
    ./modules/home/activation.nix
    ./modules/home/fish.nix
    #./modules/home/nixCats.nix
    #./modules/home/nixvim.nix
    ./modules/home/fastfetch.nix
  ];
  home.file = {
    #".config/nvim" = {
      #source = inputs.astronvim.packages.${pkgs.system}.nix-on-droid;
      #recursive = true;
    #};
    ".bash_profile".text = ''
      if [[ -z "$FISH_ALREADY_STARTED" ]]; then
      export FISH_ALREADY_STARTED=1
      exec ${pkgs.fish}/bin/fish -l
      fi
    '';
  };
  xdg.configFile = {
    "nvim" = {
      source = ./modules/home/NVIM;
      recursive = true;
    };
  };
  home.packages = (with pkgs; [
    #PKGS
  ]) ++ [
      #inputs.herdr.packages.aarch64-linux.default
  ];
  
  programs.tmux = {
    enable = true;
  };
 
  programs.yazi = {
    enable = true;
    settings = {
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # 3. Global Declarative Git configuration
  programs.git = {
    settings = {
      init.defaultBranch = "master";
      safe.directory = "*";
      user = {
        name = "OG-OXY";       # <-- Change to your name
        email = "ogoxy.yt@gmail.com"; # <-- Change to your email
      };
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "NixOS" = {
        hostname = "100.99.131.97";
        port = 22;
        user = "ty";
        extraOptions = {
          "StrictHostKeyChecking" = "no";
          "UserKnownHostsFile" = "/dev/null";
        };
      };
    };
  };

  # 4. Home Manager self-activation toggle
  programs.home-manager.enable = true;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
    pinentry = {
      package = pkgs.pinentry-curses;
    };
  };
}
