{ inputs, lib, ... }: {

  flake-file.inputs = {
    niri-flake = {
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];

  flake.aspects.niri =
    {
      outputs,
      ...
    }:
    {
      nixos = { pkgs, ... }: {
        imports = [ inputs.niri-flake.nixosModules.niri ];
        niri-flake.cache.enable = false;
        programs.niri = {
          enable = true;
          package = pkgs.niri-unstable;
        };

        environment = {
          variables.NIXOS_OZONE_WL = "1";

          systemPackages = with pkgs; [
            xwayland-satellite
            wl-clipboard
          ];
        };
      };

      home =
        let
          outputDefaults = name: {
            inherit name;
            enable = true;
            mode = {
              width = 1920;
              height = 1080;
              refresh = 60.00;
            };
            position = {
              x = 0;
              y = 0;
            };
            scale = 1.0;
          };
        in
        {
          programs.niri = {
            settings = {
              outputs = builtins.mapAttrs (
                name: output: lib.recursiveUpdate (outputDefaults name) output
              ) outputs;

              gestures = {
                hot-corners.enable = false;
              };

              prefer-no-csd = true;

              input = {
                focus-follows-mouse = {
                  enable = true;
                  max-scroll-amount = "1%";
                };
                mouse = {
                  accel-speed = 0.0;
                  accel-profile = "flat";
                };
                keyboard.xkb = {
                  layout = "de";
                  variant = "nodeadkeys";
                };
              };

              layout = {
                default-column-width = {
                  proportion = 0.5;
                };
                preset-column-widths = [
                  { proportion = 1. / 3.; }
                  { proportion = 1. / 2.; }
                  { proportion = 2. / 3.; }
                ];
                border = {
                  width = 2;
                };
                gaps = 2;
                struts = {
                  left = 2;
                  right = 2;
                  bottom = 2;
                  top = 2;
                };
              };

              screenshot-path = "~/media/images/screenshots/Screenshot+%Y-%m-%d+%H-%M-%S";

              window-rules = [
                {
                  geometry-corner-radius = {
                    bottom-left = 7.0;
                    bottom-right = 7.0;
                    top-left = 7.0;
                    top-right = 7.0;
                  };
                  clip-to-geometry = true;
                  open-maximized = true;
                  # open-maximized-to-edges = false;
                }
                {
                  matches = [
                    {
                      app-id = "kitty";
                    }
                  ];
                  open-maximized = false;
                }
              ];

              hotkey-overlay.skip-at-startup = true;

              binds = {

                "Mod+Q".action.close-window = [ ];
                "Mod+Shift+Return".action.fullscreen-window = [ ];

                # TODO: compat aspects
                "Mod+Space".action.spawn = "kitty";
                "Mod+A".action.spawn-sh = "vicinae toggle";

                "Mod+Shift+S".action.screenshot = { };

                "Mod+H".action.focus-column-left = [ ];
                "Mod+J".action.focus-window-or-workspace-down = [ ];
                "Mod+K".action.focus-window-or-workspace-up = [ ];
                "Mod+L".action.focus-column-right = [ ];
                "Mod+Shift+H".action.move-column-left = [ ];
                "Mod+Shift+J".action.move-window-down-or-to-workspace-down = [ ];
                "Mod+Shift+K".action.move-window-up-or-to-workspace-up = [ ];
                "Mod+Shift+L".action.move-column-right = [ ];
                "Mod+WheelScrollDown".action.focus-workspace-down = [ ];
                "Mod+WheelScrollUp".action.focus-workspace-up = [ ];

                "Mod+O".action.toggle-window-floating = [ ];
                "Mod+I".action.switch-preset-column-width = [ ];
                "Mod+Return".action.maximize-column = [ ];

                "Mod+Escape".action.toggle-overview = [ ];

                # TODO: compat aspects
                "XF86AudioRaiseVolume".action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+";
                "XF86AudioLowerVolume".action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
                "XF86AudioMute".action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
                "XF86AudioMicMute".action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

                # TODO: compat aspects
                "XF86MonBrightnessUp".action.spawn-sh = "brightnessctl set 10%+";
                "XF86MonBrightnessDown".action.spawn-sh = "brightnessctl set 10%-";
              };
            };
          };
        };
    };
}
