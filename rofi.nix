{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "drun,run";
      show-icons = true;
      terminal = "wezterm";
    };
    theme = "theme";
  };

  xdg.configFile."rofi/theme.rasi".text = ''
    * {
      font: "JetBrainsMono Nerd Font 11";
      text-color: #4a4f5a;
      background-color: transparent;
    }

    window {
      background-color: #f4f6fa;
      border: 1px;
      border-color: #cdd2dc;
      border-radius: 10px;
      padding: 8px;
    }

    mainbox {
      padding: 6px 10px;
      children: [ "inputbar", "listview" ];
    }

    inputbar {
      background-color: #f8f9fc;
      border-radius: 8px;
      padding: 6px 8px;
      spacing: 8px;
    }

    prompt {
      text-color: #7a808c;
    }

    textbox-prompt-colon {
      expand: false;
    }

    entry {
      text-color: #4a4f5a;
    }

    listview {
      padding: 8px 0;
      spacing: 4px;
      fixed-height: false;
      dynamic: true;
    }

    element {
      background-color: transparent;
      text-color: #6a707c;
      padding: 4px 8px;
      border-radius: 8px;
    }

    element selected {
      background-color: #d7dce6;
      text-color: #3c404a;
    }

    element alternate {
      background-color: #f0f3f8;
    }

    element-icon {
      size: 18;
      padding: 0 6px 0 2px;
    }

    element-text {
      vertical-align: 0.5;
    }
  '';
}
