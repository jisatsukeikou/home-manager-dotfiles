{ config, pkgs, ... }:

let
  # Caps lock state from LED (SwayOSD reads wrong LED with multiple keyboards)
  caps-lock-notify = pkgs.writeShellScriptBin "caps-lock-notify" ''
    sleep 0.06
    v=0
    for led in input9::capslock input25::capslock; do
      if [ -r "/sys/class/leds/$led/brightness" ]; then
        v=$(cat "/sys/class/leds/$led/brightness")
        break
      fi
    done
    if [ "$v" = "1" ]; then
      notify-send "Caps Lock On"
    else
      notify-send "Caps Lock Off"
    fi
  '';

  # Light silver theme (matches Waybar / Rofi / Hyprlock)
  swayosd-css = ''
    /* SwayOSD – default bar, our colors only */
    window#osd {
      background-color: rgba(244, 246, 250, 0.95);
      border-color: rgba(205, 210, 220, 0.9);
      color: #4a4f5a;
    }

    #container {
      color: #4a4f5a;
    }

    #container > label {
      color: #4f5562;
    }

    scale trough {
      background-color: rgba(220, 225, 234, 0.9);
      min-height: 4px;
      min-width: 80px;
    }

    scale highlight {
      background-color: rgba(160, 170, 190, 0.95);
    }

    scale slider {
      background-color: rgba(74, 79, 90, 0.9);
      min-width: 8px;
      min-height: 8px;
    }

    #container > image {
      color: #5b606c;
      -gtk-icon-size: 18px;
      -gtk-icon-transform: scale(0.7);
    }
  '';
in
{
  services.swayosd = {
    enable = true;
    topMargin = 0.9;
    stylePath = "${config.xdg.configHome}/swayosd/style.css";
  };

  xdg.configFile."swayosd/style.css".text = swayosd-css;
}
