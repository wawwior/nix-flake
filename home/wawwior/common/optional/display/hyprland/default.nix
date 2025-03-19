{
  inputs,
  pkgs,
  config,
  ...
}:
{

  imports = [
    ./keybinds.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd.enable = true;
    xwayland.enable = true;
    settings = {

      monitor = "${config.display.name},${config.display.mode},0x0,${builtins.toString config.display.scale}";

      xwayland = {
        force_zero_scaling = true;
        use_nearest_neighbor = false;
      };

      general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 2;
        resize_on_border = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 7;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 7, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
      };

      input = {
        kb_layout = "de";
        kb_variant = "nodeadkeys";
        follow_mouse = 1;
        accel_profile = "flat";
        touchpad = {
          scroll_factor = 0.2;
          natural_scroll = true;
        };
      };

      gestures = {
        workspace_swipe = true;
      };

      cursor = {
        no_hardware_cursors = 1;
      };

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "NIXOS_OZONE_WL,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "GDK_BACKEND,wayland,x11,*"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "CLUTTER_BACKEND,wayland"
      ];
    };
  };
}
