{
  pkgs,
  #config,
  #lib,
  #inputs,
  ...
}:

let
  allDefaultParsers = builtins.filter pkgs.lib.isDerivation (
    pkgs.lib.attrValues pkgs.tree-sitter-grammars
  );
  catchAllTreesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (
    plugins:
    allDefaultParsers
    ++ [
      plugins.tree-sitter-norg
      plugins.tree-sitter-norg-meta
    ]
  );
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = [
      catchAllTreesitter
    ];
    extraWrapperArgs = [
      "--set"
      "NVIM_TREESITTER_PARSERS"
      "${catchAllTreesitter}/parser"
    ];
  };
}
