{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "atlas"; 
  networking.networkmanager.enable = true;
  time.timeZone = "America/Denver";

  services.xserver.displayManager.gdm.enable = true;
	programs.hyprland = {
	  enable = true;
		xwayland.enable = true;
	};
	environment.sessionVariables.NIXOS_OZONE_WL = "1";


  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  users.users.junius = {
    isNormalUser = true;
    description = "atlas";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "junius";

  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
		xorg.libX11
    wget
    git
    ghostty
		hyprpaper
		waybar
		obsidian
		clang
		llvm
		llvmPackages.llvm
		gcc
		gnumake
		odin
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
		nerd-fonts.iosevka
  ];


  nix.settings.experimental-features = [ "nix-command" "flakes"];
  system.stateVersion = "25.05";
}
