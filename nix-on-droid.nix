{ pkgs, config, lib, inputs, ... }: {
  
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      auto-optimise-store = true
    '';
  };
  
  user.shell = "${pkgs.fish}/bin/fish";

  environment.sessionVariables = {
    PATH = "$HOME/.local/bin:$PATH";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # System PKGS.
  environment.packages = (with pkgs; [
    fish
    neovim
    vis
    git
    openssh
    claude-code
    llama-cpp
    # Neovim LSP, Linters, and Formatters.
    tree-sitter
    pyright
    black
    nil
    nixd
    nix
    nixfmt
    lua-language-server
    stylua
    alejandra
    nodePackages.vscode-langservers-extracted
    nodePackages.prettier
    marksman
    jq
    jq-lsp
    # GNU Core-Lib/Utils.
    gawk
    curl
    wget2
    wget
    ripgrep
    fd
    gnumake
    gcc
    nodejs
    ncurses
    pinentry-curses
    procps
    killall
    diffutils
    findutils
    util-linux
    tzdata
    hostname
    man
    gnugrep
    gnupg
    gnused
    gnutar
    bzip2
    gzip
    xz
    zip
    unzip
  ]) ++ [
    #inputs.nvf.packages.aarch64-linux.default
  ];

  environment.etcBackupExtension = ".bak";
  time.timeZone = "America/New_York";
  system.stateVersion = "24.05";
}
