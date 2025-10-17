{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  # TODO: I'm sure this is the intended way...
  actions = (inputs.niri.homeModules.config { inherit config pkgs; }).config.lib.niri.actions;

  mod = a: b: a - (b * (a / b));

  cross =
    prefix: suffix:
    lib.flatten (
      lib.mapAttrsToList (
        namePrefix: valuePrefix:
        lib.mapAttrsToList (nameSuffix: valueSuffix: {
          name = "${namePrefix}${nameSuffix}";
          value = "${valuePrefix}${valueSuffix}";
        }) suffix
      ) prefix
    );

  mapBoth = fn: set: builtins.listToAttrs (lib.mapAttrsToList fn set);

  binds =
    set:
    builtins.listToAttrs (
      builtins.map
        (attr: {
          inherit (attr) name;
          value = {
            action = actions."${attr.value}";
          };
        })
        (
          cross (mapBoth (name: value: {
            name = "${name}+";
            value = "${value}-";
          }) set.prefix) set.suffix
        )
    );
in
{
  imports = [ inputs.niri.nixosModules.niri ];
  niri-flake.cache.enable = false;
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
  environment.systemPackages = [
    pkgs.xwayland-satellite
    pkgs.wl-clipboard-rs
  ];
  home-manager.users =
    with builtins;
    (mapAttrs (
      name: value:
      lib.mkIf value.graphical (
        let
        in
        {

          programs.wofi.enable = true;

          services.mako = {
            enable = true;
            settings = {
              border-radius = 5;
              default-timeout = 3000;
            };
          };

          programs.niri = {
            settings = {
              outputs.main = {
                enable = true;
                inherit (config.hostSpec.display) name mode;
              };

              prefer-no-csd = true;

              input = {
                focus-follows-mouse.enable = true;
                mouse.accel-profile = "flat";
                keyboard.xkb = {
                  layout = "de";
                  variant = "nodeadkeys";
                };
              };

              layout = {
                default-column-width = {
                  proportion = 0.5;
                };
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

              workspaces = {
                "00-scratchpad" = {
                  name = "scratchpad";
                };
                "01-main" = {
                  name = "main";
                };
              };

              screenshot-path = "~/media/images/screenshots/Screenshot+%Y-%m-%d+%H-%M-%S";

              environment = {
                "NIXOS_OZONE_WL" = "1";
              };

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

              binds =
                with actions;
                {

                  "Mod+Q".action = close-window;
                  "Mod+Return".action = fullscreen-window;
                  # "Mod+?".action = show-hotkey-overlay;

                  "Mod+Space".action = spawn "kitty";
                  "Mod+A".action = spawn "wofi" "--show" "drun";

                  "Mod+Shift+S".action = screenshot;

                  "Mod+J".action = focus-window-or-workspace-down;
                  "Mod+K".action = focus-window-or-workspace-up;
                  "Mod+Shift+J".action = move-window-down-or-to-workspace-down;
                  "Mod+Shift+K".action = move-window-up-or-to-workspace-up;
                  "Mod+WheelScrollDown".action = focus-workspace-down;
                  "Mod+WheelScrollUp".action = focus-workspace-up;

                  "Mod+O".action = toggle-window-floating;

                  "Mod+Escape".action = toggle-overview;
                }
                // (binds {
                  prefix = {
                    "Mod" = "focus";
                    "Mod+Shift" = "move";
                  };
                  suffix = {
                    "H" = "column-left";
                    "L" = "column-right";
                  };
                })
                // builtins.listToAttrs (
                  builtins.genList (x: {
                    name = "Mod+${builtins.toString (mod (x + 1) 10)}";
                    value.action = focus-workspace (x + 1);
                  }) 10
                );
            };
          };
        }
      )
    ) config.userSpec.users);
}
