{ inputs, lib, ... }:
{

  flake-file.inputs = {
    niri-flake.url = "github:epireyn/niri-flake";
  };

  flake.aspects.niri =
    {
      outputs,
      ...
    }:
    {
      name = "niri";

      nixos = { pkgs, ... }: {
        imports = [ inputs.niri-flake.nixosModules.niri ];
        nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];
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
        { capabilities, ... }: {
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

              screenshot-path = "~/media/images/screenshots/screenshot+%Y-%m-%d+%H-%M-%S";

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
                }
                # TODO: uhh all terminals? (capability?)
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

              binds =
                let
                  commands = capabilities.commands or { };
                  bind =
                    bind: cmd:
                    lib.optionalAttrs (commands.${cmd} or null != null) {
                      ${bind}.action.spawn-sh = commands.${cmd};
                    };
                in
                {

                  "Mod+Q".action.close-window = [ ];
                  "Mod+Shift+Return".action.fullscreen-window = [ ];

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
                }
                // builtins.foldl' (acc: set: acc // set) { } [
                  (bind "Mod+Space" "terminal")
                  (bind "Mod+A" "launcher")

                  (bind "XF86AudioRaiseVolume" "raiseVolume")
                  (bind "XF86AudioLowerVolume" "lowerVolume")
                  (bind "XF86AudioMute" "mute")
                  (bind "XF86AudioMicMute" "micMute")

                  (bind "XF86MonBrightnessUp" "brightnessUp")
                  (bind "XF86MonBrightnessDown" "brightnessDown")
                ];
            };
          };
        };
    };
}
