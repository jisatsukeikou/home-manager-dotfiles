{ pkgs, ... }:

let
  scripts = {
    toggleAudio = pkgs.writeShellScriptBin "toggle-audio" ''
      SEARCH_QUERY="$1"

      TARGET_ID=$(wpctl status | awk '/Audio/,/Video/' | grep -i "$SEARCH_QUERY" | grep -oE '[0-9]+' | head -n 1)

      if [ -z "$TARGET_ID" ]; then
      echo "Error: No sink matching '$SEARCH_QUERY' was found."
      exit 1
      fi

      wpctl set-default "$TARGET_ID"
      echo "Default sink successfully set to ID $TARGET_ID (matching '$SEARCH_QUERY')."
    '';
  };

in {
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
    ./dunst.nix
    ./hyprland.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprtoolkit.nix
    ./rofi.nix
    ./swayosd.nix
    ./wezterm.nix
    ./waybar.nix
    # catppuccin.homeManagerModules.catppuccin
  ];

  targets.genericLinux.enable = true;

  # NixOS Hyprland/UWSM sets XDG_MENU_PREFIX=hyprland- in systemd; KDE needs plasma-
  # for plasma-applications.menu (see hyprland.nix dbus-update-activation-environment).
  home.sessionVariables = {
    XDG_MENU_PREFIX = "plasma-";
    QT_QPA_PLATFORMTHEME = "kde";
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    #discord
    ayugram-desktop
    brightnessctl
    dunst
    fastfetch
    figma-linux
    grc
    grim
    hyprpolkitagent
    jdk
    keepass
    kitty
    libreoffice
    pavucontrol
    pinta
    slurp
    swappy
    vscode-fhs
    wezterm
    wl-clipboard
    zulip

    scripts.toggleAudio
  ];

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
      shellAliases = {
        cls = "clear";
      };
      functions = {
      };
      plugins = [
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
        {
          name = "bobthefisher";
          src = pkgs.fishPlugins.bobthefisher.src;
        }
        {
          name = "you-should-use";
          src = pkgs.fishPlugins.fish-you-should-use.src;
        }
        {
          name = "colored-man-pages";
          src = pkgs.fishPlugins.colored-man-pages.src;
        }
      ];
    };

    mpv = {
      enable = true;
    };

    rofi = {
      enable = true;
      package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    yazi = {
      enable = true;
      settings = {
        preview = {
          max_width = 3840;
          max_height = 2160;
          # ueberzug_scale = 1;
        };
      };
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        ignore_dbus_inhibit = false;
      };
    };
  };
}
