{config, pkgs, lib, ...}:

{
  # Install Neovim and dependencies
  home.packages = with pkgs; [
    # Tools required for Telescope
    ripgrep
    fzf
    gcc
    gnumake

    # Language Servers
    lua-language-server
    pyright
    nil # nix language server
    nixpkgs-fmt # nix formatter

    # Needed for lazy.nvim
    nodejs
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

}
