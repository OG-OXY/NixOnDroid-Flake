{ pkgs, config, lib, inputs, ... }: {
  
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  
  user.shell = "${pkgs.fish}/bin/fish";

  environment.sessionVariables = {
    PATH = "$HOME/.local/bin:$PATH";
    EDITOR = "vis";
    VISUAL = "vis";
    ANTHROPIC_BASE_URL = "http://localhost:8080";
    ANTHROPIC_API_KEY = "local";
    ANTHROPIC_AUTH_TOKEN = "local";
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
    tree
    dysk
    btop
    # Neovim LSP, Linters, and Formatters.
    tree-sitter
    pyright
    black
    nixd
    nix
    nixfmt
    lua-language-server
    stylua
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
    #inputs.nixCats.packages.aarch64-linux.default
    #inputs.nvf.packages.aarch64-linux.default
  ];

  environment.etcBackupExtension = ".bak";
  time.timeZone = "America/New_York";
  system.stateVersion = "24.05";
}
