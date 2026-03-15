{ config, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = true;
      splash_offset = 2.0;

      preload = [
        "~/Pictures/wallpaper.png"
      ];

      wallpaper = [
        "DP-1,~/Pictures/wallpaper.png"
        "DP-2,~/Pictures/wallpaper.png"
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    xwayland = {
      enable = true;
    };

     settings = {
      "$terminal" = "wezterm";
      "$mod" = "SUPER";
      "$menu" = "rofi -show drun";
      "$reload" = "hyprctl reload";
      "$fileManager" = "dolphin";
      "$lock" = "hyprlock";

      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 3;
        "col.active_border" = "rgba(9ec9ffff)";
        "col.inactive_border" = "rgba(9ec9ff99)";
      };

      windowrule = [
        {
          name = "chats";
          "match:workspace" = "3";
          monitor = "DP-1";
        }
        {
          name = "tg";
          "match:class" = "org.telegram.desktop";
          workspace = 3;
        }
        {
          name = "firefox";
          "match:class" = "firefox";
          workspace = 2;
        }
        {
          name = "VPN";
          "match:class" = "AmneziaVPN";
          float = "on";
        }
      ];

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 10;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          new_optimizations = true;
        };

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      animations = {
        enabled = true;

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default, slidevert"
          "specialWorkspace, 1, 6, default, fade"
        ];
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # you probably want this
      };

      monitor = [
        "DP-1, preferred, 0x0, auto"
        "DP-2, preferred, 2560x0, auto"
      ];

      bind = [
        "$mod, RETURN, exec, $terminal"
        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, $fileManager"
        "$mod, PRINT, exec, grim -g \"$(slurp)\" - | wl-copy"  # Manually select a region
        "$mod, Q, exec, $reload"
        "$mod, V, togglefloating,"
        "$mod, R, exec, $menu"
        "$mod, L, exec, $lock"
        "$mod, P, pseudo," # dwindle
        "$mod, J, togglesplit," # dwindle

        # Move focus with mod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod SHIFT, right, moveworkspacetomonitor, DP-1"
        "$mod SHIFT, left, moveworkspacetomonitor, DP-2"

        # Switch workspaces with mod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move active window to a workspace with mod + SHIFT + [0-9]
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ];

      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      input = {
        kb_layout = "us,ru";
        kb_options = "grp:ctrl_space_toggle,grp_led:scroll,compose:ralt";
        follow_mouse = true;
        accel_profile = "flat";
        sensitivity = 0;
      };

      env = [
        "NVD_BACKEND,direct"
        "NIXOS_OZONE_WL,1"
        "GDK_SCALE,2"
        "XCURSOR_SIZE,32"
        "_JAVA_AWT_WM_NONREPARENTING,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORM,wayland"
        "SDL_VIDEODRIVER,wayland"
        "GDK_BACKEND,wayland"
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "ANDROID_JAVA_HOME,${pkgs.jdk.home}"
        "ANDROID_HOME,~/.androidsdk"
        "GTK_APPLICATION_PREFER_DARK_THEME,1"
      ];

      exec-once = [
        "${pkgs.hyprpaper}/bin/hyprpaper"
        "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store"
        "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch cliphist store"
        "eval $(gnome-keyring-daemon --start --components=secrets,ssh,gpg,pkcs11)"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &"
        "hash dbus-update-activation-environment 2>/dev/null"
        "export SSH_AUTH_SOCK"
        "systemctl --user start hyprpolkitagent"
        #"waybar"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      misc = {
        focus_on_activate = true;
      };
    };
  };
}
