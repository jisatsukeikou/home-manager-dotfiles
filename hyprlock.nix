{ config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };

      background = [
        {
          monitor = "";
          path = "~/Pictures/wallpaper.png";
          blur_passes = 3;
          blur_size = 6;
          color = "rgba(244,246,250,1.0)";
        }
      ];

      label = [
        # Time in center
        {
          monitor = "";
          text = "$TIME";
          font_family = "JetBrainsMono Nerd Font";
          font_size = 46;
          position = "0, -40";
          halign = "center";
          valign = "center";
          color = "rgba(110,115,128,1.0)";   # darker, shared color
        }

        # Date under time
        {
          monitor = "";
          text = "cmd[update:1000] date +\"%A, %Y-%m-%d\"";
          font_family = "JetBrainsMono Nerd Font";
          font_size = 18;
          position = "0, 8";
          halign = "center";
          valign = "center";
          color = "rgba(110,115,128,1.0)";   # same as time
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "420, 64";
          outline_thickness = 2;
          outer_color = "rgba(205,210,220,0.90)";
          inner_color = "rgba(244,246,250,0.95)";
          font_color  = "rgba(120,125,138,1.0)";

          check_color = "rgba(190,210,220,0.95)";
          fail_color  = "rgba(230,160,160,0.95)";

          placeholder_text = "パスワード...";
          fade_on_empty = false;

          position = "0, 110";
          halign = "center";
          valign = "center";
          rounding = 14;
          dots_center = true;
          dots_size = 0.18;
          dots_spacing = 0.24;
        }
      ];
    };
  };
}
