{config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  # Standard .config/directory
  configs = {
	  waybar = "waybar";
		hypr = "hypr";
    nvim = "nvim";
		wofi = "wofi";
    ghostty = "ghostty";
  };
in

{
  home.username = "junius";
  home.homeDirectory = "/home/junius";
  programs.git = {
    enable = true;
    userName = "notJunius";
    userEmail = "120129256+notJunius@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  home.stateVersion = "25.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#atlas";
    };
    };
      xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

      home.packages = with pkgs; [
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
		wofi
    xwallpaper
    unzip
    fzf
    kdePackages.dolphin
		brightnessctl
		libreoffice
		obs-studio
  ];
  }

