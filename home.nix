{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ophanimous";
  home.homeDirectory = "/home/ophanimous";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  imports = [
    # Include the results of the hardware scan
    # ./dunst.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./rofi.nix
    ./wezterm.nix
    ./waybar.nix
    # catppuccin.homeManagerModules.catppuccin
  ];

  targets.genericLinux.enable = true;

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    #discord
    dunst
    fastfetch
    figma-linux
    flameshot
    grim
    helvum
    hyprpolkitagent
    jdk
    keepass
    kitty
    libreoffice
    slurp
    steam
    #telegram-desktop
    #ayugram-desktop
    #kotatogram-desktop
    teams-for-linux
    vscode-fhs
    wezterm
    wl-clipboard

    (writeShellScriptBin "zapret" ''
      #!${pkgs.bash}/bin/bash
      ssh -q maint@172.16.10.1 "sudo zapret_toggle uncomment"
    '')
    (writeShellScriptBin "unzapret" ''
      #!${pkgs.bash}/bin/bash
      ssh -q maint@172.16.10.1 "sudo zapret_toggle comment"
    '')
  ];

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        adb kill-server
        adb start-server
      '';
      # plugins = [
      #   # Enable a plugin (here grc for colorized command output) from nixpkgs
      #   {
      #     name = "grc";
      #     src = pkgs.fishPlugins.grc.src;
      #   }
      # ];
    };

    mpv = {
      enable = true;
    };

    rofi = {
      enable = true;
      package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };
    };
  };
}
