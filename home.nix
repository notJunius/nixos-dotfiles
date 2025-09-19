{ config, pkgs, ... }:


{
  home.username = "junius";
  home.homeDirectory = "/home/junius";
  programs.git = {
    enable = true;
    userName = "notJunius";
    userEmail = "120129256+notJunius@users.noreply.github.com";
  };
  home.stateVersion = "25.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I use nixos, btw";
    };
  };
  home.file.".config/qtile".source = ./config/qtile;
  home.file.".config/nvim".source = ./config/nvim;

  home.packages = with pkgs; [
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    unzip
  ];
}
