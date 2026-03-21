{ pkgs, ... }:
{
  services.dunst = {
    enable = true;

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };

    settings = {
      global = {
        follow = "none";
        monitor = 1;
        width = 370;
        separator_height = 1;
        padding = 16;
        horizontal_padding = 16;
        origin = "bottom-right";
        offset = "20x20";
        frame_width = 1;
        sort = "update";
        idle_threshold = 120;
        alignment = "left";
        word_wrap = "yes";
        transparency = 10;
        format = "<b>%s</b>: %b";
        markup = "full";
        min_icon_size = 24;
        max_icon_size = 64;

        # Light silver theme
        font = "JetBrainsMono Nerd Font 11";
        background = "#F4F6FA";
        foreground = "#4A4F5A";
        frame_color = "#CDD2DC";
        separator_color = "frame";
        corner_radius = 10;
      };

      urgency_low = {
        background = "#F8F9FC";
        foreground = "#6A707C";
        frame_color = "#DDE2EB";
        timeout = 4;
      };

      urgency_normal = {
        background = "#F4F6FA";
        foreground = "#4A4F5A";
        frame_color = "#CDD2DC";
        timeout = 7;
      };

      urgency_critical = {
        background = "#F4F6FA";
        foreground = "#9A5A5A";
        frame_color = "#D89A9A";
        timeout = 0;
      };
    };
  };
}
