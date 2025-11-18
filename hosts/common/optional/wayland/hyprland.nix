{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  hyprland = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
  hyprland-pkg = (
    hyprland.hyprland.override {
      # Unused right now
    }
  );
in
{
  programs.hyprland = {
    enable = true;
    package = hyprland-pkg;
    portalPackage = hyprland.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
    withUWSM = true;
  };

  environment.systemPackages = with pkgs; [
    egl-wayland
    xwayland
    grim
    slurp
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # TODO: Hyprpolkit for 25.05!!
  # security.polkit.package = pkgs.hyprpolkitagent;

  home-manager.users =
    with builtins;
    (mapAttrs (
      name: value:
      lib.mkIf value.graphical {
        home.packages = [
          pkgs.wl-clipboard
        ];

        programs.wofi.enable = true;

        programs.waybar = {
          systemd.enable = true;
          enable = true;
          settings = [
            {
              layer = "top";
              position = "top";
              height = 36;

              modules-left = [ "clock" ];
              modules-center = [ "hyprland/workspaces" ];
              modules-right = [
                "tray"
                "wireplumber"
                "memory"
                "cpu"
                "temperature"
                "battery"
              ];

              temperature = {
                hwmon-path-abs = "/sys/devices/platform/coretemp.0/hwmon";
                input-filename = "temp1_input";
                format = "{temperatureC}°C";
              };
            }
          ];

          style = lib.mkAfter ''
            /* css */
              * {
                font-family: "DejaVuSansM Nerd Font Mono";
                font-size: 13px;
              }
          '';
        };

        services.mako = {
          enable = true;
          settings = {
            border-radius = 5;
            default-timeout = 3000;
          };
        };

        wayland.windowManager.hyprland = {
          enable = true;
          package = null;
          portalPackage = null;
          systemd.enable = true;
          settings =
            let

              mainMod = "Super";

              # v TODO: do something about these v

              terminal = # sh
                ''
                  kitty
                '';

              runner = # sh
                ''
                  wofi --show drun
                '';

              screenshot = # sh
                ''
                  grim -g "$(slurp)" - | wl-copy
                '';

              modeStr = mode: "${toString mode.width}x${toString mode.height}@${toString mode.refresh}";
            in
            {

              monitor = "${config.hostSpec.display.name},${modeStr config.hostSpec.display.mode},0x0,${toString config.hostSpec.display.scale}";

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
                enable_anr_dialog = false;
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

              device = [
                {
                  name = "sony-interactive-entertainment-dualsense-wireless-controller-touchpad";
                  enabled = false;
                }
              ];

              # TODO: update
              # gestures = {
              #   workspace_swipe = true;
              # };

              cursor = {
                no_hardware_cursors = false;
              };

              env = [
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

              windowrule = [
                "match:class .*, suppress_event maximize"
                "match:initial_class ^(steam_app_)\\d*, render_unfocused true"
                "match:initial_class ^com\\.mojang\\.minecraft.*, render_unfocused true"
                "match:initial_class ^Minecraft.*, render_unfocused true"
                "match:xwayland true, no_initial_focus true"
              ];

              bind = [
                "${mainMod}, q, killactive"
                "${mainMod}, Return, fullscreen"

                "${mainMod}, Space, exec, ${terminal}"
                "${mainMod}, a, exec, ${runner}"

                "${mainMod}+Shift, s, exec, ${screenshot}"

                "${mainMod}, h, movefocus, l"
                "${mainMod}, l, movefocus, r"
                "${mainMod}, k, movefocus, u"
                "${mainMod}, j, movefocus, d"

                "${mainMod}, 1, workspace, 1"
                "${mainMod}, 2, workspace, 2"
                "${mainMod}, 3, workspace, 3"
                "${mainMod}, 4, workspace, 4"
                "${mainMod}, 5, workspace, 5"
                "${mainMod}, 6, workspace, 6"
                "${mainMod}, 7, workspace, 7"
                "${mainMod}, 8, workspace, 8"
                "${mainMod}, 9, workspace, 9"
                "${mainMod}, 0, workspace, 10"

                "${mainMod}+Shift, 1, movetoworkspace, 1"
                "${mainMod}+Shift, 2, movetoworkspace, 2"
                "${mainMod}+Shift, 3, movetoworkspace, 3"
                "${mainMod}+Shift, 4, movetoworkspace, 4"
                "${mainMod}+Shift, 5, movetoworkspace, 5"
                "${mainMod}+Shift, 6, movetoworkspace, 6"
                "${mainMod}+Shift, 7, movetoworkspace, 7"
                "${mainMod}+Shift, 8, movetoworkspace, 8"
                "${mainMod}+Shift, 9, movetoworkspace, 9"
                "${mainMod}+Shift, 0, movetoworkspace, 10"

                "${mainMod}+Shift, h, movewindow, l"
                "${mainMod}+Shift, l, movewindow, r"
                "${mainMod}+Shift, k, movewindow, u"
                "${mainMod}+Shift, j, movewindow, d"

                "${mainMod}+Shift, Tab, movetoworkspace, special"
                "${mainMod}, Tab, togglespecialworkspace"

                "${mainMod}, i, togglefloating"
                "${mainMod}, o, togglesplit"

                "${mainMod}+Alt, 1, movetoworkspacesilent, 1"
                "${mainMod}+Alt, 2, movetoworkspacesilent, 2"
                "${mainMod}+Alt, 3, movetoworkspacesilent, 3"
                "${mainMod}+Alt, 4, movetoworkspacesilent, 4"
                "${mainMod}+Alt, 5, movetoworkspacesilent, 5"
                "${mainMod}+Alt, 6, movetoworkspacesilent, 6"
                "${mainMod}+Alt, 7, movetoworkspacesilent, 7"
                "${mainMod}+Alt, 8, movetoworkspacesilent, 8"
                "${mainMod}+Alt, 9, movetoworkspacesilent, 9"
                "${mainMod}+Alt, 0, movetoworkspacesilent, 10"
              ];

              bindl = [
                ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

                ", XF86AudioPlay, exec, playerctl play-pause"
                ", XF86AudioPause, exec, playerctl play-pause"
                ", XF86AudioNext, exec, playerctl next"
                ", XF86AudioPrev, exec, playerctl previous"
              ];

              bindel = [
                ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"

                ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
                ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
              ];

              binde = [
                "${mainMod}+Ctrl, h, resizeactive, -30 0"
                "${mainMod}+Ctrl, l, resizeactive, 30 0"
                "${mainMod}+Ctrl, k, resizeactive, 0 -30"
                "${mainMod}+Ctrl, j, resizeactive, 0 30"
              ];

              bindm = [
                "${mainMod}, mouse:272, movewindow"
                "${mainMod}, mouse:273, resizewindow"
              ];
            };
        };
      }
    ) config.userSpec.users);
}
