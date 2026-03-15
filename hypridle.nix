{ pkgs, ... }:

{
  # Make sure hypridle and brightnessctl are available
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  programs.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "hyprlock";        # optional: lock when other listeners want it
        ignore_dbus_inhibit = false;
      };

      # 30 minutes (1800s): dim screen
      listener = [
        {
          timeout = 1800;
          on-timeout = "brightnessctl -s set 10%";  # save current, set to 10%
          on-resume  = "brightnessctl -r";          # restore previous brightness
        }

        # 60 minutes (3600s): turn display off
        {
          timeout = 3600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume  = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
