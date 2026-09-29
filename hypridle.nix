{ ... }:

{
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";        # optional: lock when other listeners want it
        before_sleep_cmd = "loginctl lock-session";
        ignore_dbus_inhibit = false;
      };

      listener = [
        # 60 minutes (3600s): turn display off
        {
          timeout = 3600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume  = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          on-timeout = "loginctl lock session";
        }
      ];
    };
  };
}
