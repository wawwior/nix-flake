{ config, ... }:
{
  wayland.windowManager.hyprland.settings =
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

    in
    {

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
}
