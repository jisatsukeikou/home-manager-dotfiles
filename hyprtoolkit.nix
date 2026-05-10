{ ... }:
{
  xdg.configFile."hypr/hyprtoolkit.conf" = {
    force = true;
    text = ''
      # Light silver theme matching your Hyprland/Waybar palette

      background = 0xFFF4F6FA
      base = 0xFFF8F9FC
      text = 0xFF4A4F5A
      alternate_base = 0xFFF0F3F8
      bright_text = 0xFF3C404A

      # Hair-blue accent from wallpaper
      accent = 0xFFA1CBE4
      accent_secondary = 0xFF5F7B91

      # Typography
      h1_size = 19
      h2_size = 15
      h3_size = 13
      font_size = 11
      small_font_size = 10

      font_family = JetBrainsMono Nerd Font
      font_family_monospace = JetBrainsMono Nerd Font

      # Icon/theme shape
      icon_theme = Papirus
      rounding_large = 10
      rounding_small = 6
    '';
  };
}
