{ config, pkgs, ... }:

{
  programs.wezterm = {
    enable = true;

    extraConfig = ''
      local wezterm = require 'wezterm'

      return {
        -- Hide tabs completely
        enable_tab_bar = false,

        -- Semi-transparent window background
        window_background_opacity = 0.85,
        text_background_opacity = 0.85,

        -- Optional: pick any color scheme you like
        color_scheme = "Catppuccin Mocha",
      }
    '';
  };
}
