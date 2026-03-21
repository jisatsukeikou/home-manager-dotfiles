{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = [
      {
        layer = "top";
        position = "top";
        height = 32;
        margin = "6 12 0 12";

        "modules-left"   = [ "custom/terminal" "clock" "tray" ];
        "modules-center" = [ "hyprland/workspaces" ];
        "modules-right"  = [ "custom/gamepad" "wireplumber" "cpu" "memory" "disk" ];

        "custom/terminal" = {
          format = "";
          tooltip = "Terminal";
          "on-click" = "kitty";  # change to your terminal if needed
        };

        clock = {
          interval = 1;
          format = "{:%H:%M}";
          "tooltip-format" = "{:%A, %Y-%m-%d}";
        };

        tray = {
          "icon-size" = 16;
          spacing = 6;
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          "active-only" = false;
          "sort-by-number" = true;
          "all-outputs" = true;
          "persistent-workspaces" = {
            "*" = [ 1 2 3 4 5 6 7 8 9 10 ];
          };
          "format-icons" = {
            "1"  = "い";
            "2"  = "ろ";
            "3"  = "は";
            "4"  = "に";
            "5"  = "ほ";
            "6"  = "へ";
            "7"  = "と";
            "8"  = "ち";
            "9"  = "り";
            "10" = "ぬ";
          };
        };

        "custom/gamepad" = {
          interval = 5;
          return-type = "json";
          exec = "bash -lc 'devs=$(bluetoothctl devices Connected | cut -d\" \" -f2); for d in $devs; do info=$(bluetoothctl info \"$d\" 2>/dev/null); echo \"$info\" | grep -q \"Icon: input-gaming\" || continue; name=$(echo \"$info\" | sed -n \"s/^\\s*Name: //p\" | head -n1); [ -n \"$name\" ] || name=\"Gamepad\"; printf \"{\\\"text\\\":\\\"\\\",\\\"tooltip\\\":\\\"%s connected\\\",\\\"class\\\":\\\"connected\\\"}\" \"$name\"; exit 0; done; printf \"{\\\"text\\\":\\\"\\\",\\\"tooltip\\\":\\\"No gamepad connected\\\",\\\"class\\\":\\\"disconnected\\\"}\"'";
          format = "{}";
          on-click = "blueman-manager";
        };

        wireplumber = {
          format = "  {volume}%";
          "format-muted" = " {volume}%";
          "on-click" = "swayosd-client --output-volume mute-toggle";
          "on-scroll-up" = "swayosd-client --output-volume raise";
          "on-scroll-down" = "swayosd-client --output-volume lower";
        };

        cpu = {
          interval = 3;
          format = " {usage}%";
        };

        memory = {
          interval = 5;
          format = " {used:0.1f}G";
        };

        disk = {
          interval = 30;
          path = "/";
          format = " {free}";
        };
      }
    ];

    style = ''
      * {
        border: none;
        border-radius: 8px;
        font-family: "JetBrainsMono Nerd Font", "FiraCode Nerd Font", monospace;
        font-size: 12px;
        min-height: 0;
      }

      window#waybar {
        background: transparent;  /* bar background fully transparent */
        color: #4a4f5a;
      }

      /* Transparent main bar container */
      window#waybar > box {
        background-color: transparent;
        border-radius: 10px;
        padding: 0;
        border: none;
      }

      /* Left / center / right panels – 0.90 opacity */
      .modules-left,
      .modules-center,
      .modules-right {
        background-color: rgba(244, 246, 250, 0.90);
        border-radius: 10px;
        padding: 8px 16px;  /* taller panels */
        margin: 2px 8px;
        border: 1px solid rgba(205, 210, 220, 0.90);
      }

      /* Terminal icon launcher */
      #custom-terminal {
        padding: 0 12px;
        color: #5b606c;
      }

      #custom-terminal:hover {
        background-color: rgba(220, 225, 234, 0.90);
      }

      /* Clock and tray */
      #clock,
      #tray {
        padding: 0 10px;
      }

      #tray > * {
        margin: 0 3px;
      }

      /* Workspaces:
       * - .empty  => lighter (no windows)
       * - non-empty => darker
       * - .active => darkest + background
       */
      #workspaces {
        margin: 0 8px;
      }

      #workspaces button {
        padding: 0 11px;
        margin: 0 4px;
        background: transparent;
        border-radius: 999px;
        font-size: 13px;
        font-weight: 700;
        transition: background-color 0.15s ease, color 0.15s ease, border-color 0.15s ease;
      }

      /* Empty workspaces (no windows) – light */
      #workspaces button.empty {
        color: rgba(74, 79, 90, 0.35);
      }

      /* Workspaces that have windows (not .empty) – darker */
      #workspaces button:not(.empty) {
        color: rgba(74, 79, 90, 0.75);
      }

      /* Currently active (focused) workspace – darkest + background */
      #workspaces button.active,
      #workspaces button.focused {
        background-color: rgba(215, 220, 230, 0.90);
        color: #3c404a;
        border: 1px solid rgba(185, 191, 204, 0.90);
      }

      /* Urgent workspace */
      #workspaces button.urgent {
        background-color: rgba(246, 210, 226, 0.95);
        color: #8e4a6b;
        border: 1px solid rgba(232, 170, 200, 0.95);
      }

      #workspaces button:hover:not(.active):not(.focused) {
        background-color: rgba(230, 234, 242, 0.90);
      }

      /* Right panel: gamepad, volume, CPU, RAM, disk */
      #custom-gamepad,
      #wireplumber,
      #cpu,
      #memory,
      #disk {
        padding: 0 10px;
        color: #4f5562;
      }

      #wireplumber.muted {
        color: rgba(120, 126, 140, 0.75);
      }

      #custom-gamepad.disconnected {
        color: rgba(120, 126, 140, 0.75);
      }

      #custom-gamepad:hover,
      #wireplumber:hover,
      #cpu:hover,
      #memory:hover,
      #disk:hover {
        background-color: rgba(225, 229, 238, 0.90);
      }

      /* Optional subtle separators between right modules */
      .modules-right > widget:not(:last-child) {
        border-right: 1px solid rgba(210, 215, 225, 0.85);
        margin-right: 6px;
        padding-right: 8px;
      }
    '';
  };
}
