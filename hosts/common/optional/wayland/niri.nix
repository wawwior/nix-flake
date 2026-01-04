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
    pkgs.swaybg
  ];
  security.pam.services.hyprlock = { };
  home-manager.users =
    with builtins;
    (mapAttrs (
      name: value:
      lib.mkIf value.graphical (
        let
        in
        {

          imports = [
            inputs.vicinae.homeManagerModules.default
          ];

          programs.wofi.enable = true;

          programs.hyprlock.enable = true;

          programs.waybar = {
            systemd.enable = true;
            enable = true;
            settings = [
              {
                layer = "top";
                position = "top";
                height = 36;

                modules-left = [ "clock" ];
                modules-center = [ "tray" ];
                modules-right = [
                  "wireplumber"
                  "backlight"
                  "memory"
                  "cpu"
                  "temperature"
                  "battery"
                ];

                temperature = {
                  hwmon-path-abs = "/sys/devices/platform/coretemp.0/hwmon";
                  input-filename = "temp1_input";
                  format = " {temperatureC}°C";
                };
                clock = {
                  format = "{:%a %d-%m-%Y %R:%S}";
                  interval = 1;
                };
                wireplumber = {
                  format = "{icon} {volume}%";
                  format-muted = " MUTE";
                  format-icons = [
                    ""
                    ""
                    ""
                  ];
                };
                memory = {
                  format = " {used}G";
                };
                cpu = {
                  format = " {usage}%";
                };
                battery = {
                  bat = "BAT0";
                  format-charging = "󱐋{icon} {capacity}%";
                  format-discharging = "{icon} {capacity}%";
                  format-icons = [
                    "󰁺"
                    "󰁻"
                    "󰁼"
                    "󰁽"
                    "󰁾"
                    "󰁿"
                    "󰂀"
                    "󰂁"
                    "󰂂"
                    "󰁹"
                  ];
                };
                backlight = {
                  format = "󰃠 {percent}%";
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

          services.vicinae = {
            enable = true;
            systemd = {
              enable = true;
              autoStart = true;
            };
            settings = {
              theme = {
                dark = {
                  name = "stylix";
                };
              };
            };
            extensions =
              let
                exts = inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system};
              in
              [
                exts.niri
                exts.nix
              ];
          };

          programs.niri = {
            settings = {
              outputs = {
                main = {
                  enable = true;
                  inherit (config.hostSpec.display) name mode;
                  position = {
                    x = 0;
                    y = 0;
                  };
                  scale = 1;
                };
              };

              spawn-at-startup = [
                {

                  command = [
                    (lib.getExe pkgs.swaybg)
                    "-i"
                    "${pkgs.fetchurl {
                      name = "wallpaper.png";
                      url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/os/nix-black-4k.png";
                      sha256 = "sha256-HRZYeKDmfA53kb3fZxuNWvR8cE96tLrqPZhX4+z4lZA=";
                    }}"
                  ];
                }
              ];

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

              environment = {
                "NIXOS_OZONE_WL" = "1";
                "ELECTRON_OZONE_PLATFORM_HINT" = "auto";
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
                  "Mod+Shift+Return".action = fullscreen-window;
                  # "Mod+?".action = show-hotkey-overlay;
                  "Mod+Shift+Escape".action = spawn "hyprlock";

                  "Mod+Space".action = spawn "kitty";
                  "Mod+A".action = spawn "vicinae" "toggle";

                  "Mod+Shift+S".action.screenshot = { };

                  "Mod+H".action = focus-column-left;
                  "Mod+J".action = focus-window-or-workspace-down;
                  "Mod+K".action = focus-window-or-workspace-up;
                  "Mod+L".action = focus-column-right;
                  "Mod+Shift+H".action = move-column-left;
                  "Mod+Shift+J".action = move-window-down-or-to-workspace-down;
                  "Mod+Shift+K".action = move-window-up-or-to-workspace-up;
                  "Mod+Shift+L".action = move-column-right;
                  "Mod+WheelScrollDown".action = focus-workspace-down;
                  "Mod+WheelScrollUp".action = focus-workspace-up;

                  "Mod+O".action = toggle-window-floating;
                  "Mod+I".action = switch-preset-column-width;
                  "Mod+Return".action = maximize-column;

                  "Mod+Escape".action = toggle-overview;
                  "XF86AudioRaiseVolume".action = spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+";
                  "XF86AudioLowerVolume".action = spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
                  "XF86AudioMute".action = spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
                  "XF86AudioMicMute".action = spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

                  "XF86MonBrightnessUp".action = spawn-sh "brightnessctl set 10%+";
                  "XF86MonBrightnessDown".action = spawn-sh "brightnessctl set 10%-";
                }
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
