{ config, pkgs, ... }:


let
    dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
    # Standard .config/directory
    configs = {
        qtile = "qtile";
        nvim = "nvim";
        dwm = "dwm";
        dmenu = "dmenu";
        st = "st";
        hypr = "hypr";
        ghostty = "ghostty";
        odin = "odin";
        waybar = "waybar";
        zathura = "zathura";
    };
in
{
  imports = [
    ./modules/neovim.nix
    ./modules/suckless.nix
  ];

  xdg.configFile = builtins.mapAttrs (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
  }) configs;
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
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#atlas";
    };
    initExtra = ''
      export PS1='\u@\h \W \\$ '
      export PATH="/home/junius/.config/odin:$PATH"
    '';
  };


  home.packages = with pkgs; [
    unzip
    pavucontrol
    rofi 
    slock
    xclip
    xwallpaper
    libreoffice
    zathura
    obsidian
    love
    kdePackages.okular
    spotify
    obs-studio
    vlc
    kdePackages.kdenlive
    nix-diff
    discord
    gimp
  ];
}
