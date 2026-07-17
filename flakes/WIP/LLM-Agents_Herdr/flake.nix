{
  description = "Isolated Herdr package reading prebuilt binaries from llm-agents.nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    llm-agents.url = "github:numtide/llm-agents";
    llm-agents.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, llm-agents, ... }: {
    packages.aarch64-linux.default = llm-agents.packages.aarch64-linux.herdr;
    environment.packages = (with nixpkgs; [
      herdr
      claude-code
      open-code
      qwen-code
      gemini-cli
    ]);
  };
}
