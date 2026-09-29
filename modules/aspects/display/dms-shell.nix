{ self, inputs, ... }: {
  flake-file.inputs = {
    dms.url = "github:AvengeMedia/DankMaterialShell";
  };
  flake.aspects.dms-shell = {
    nixos = {
      imports = [
        inputs.dms.nixosModules.dank-material-shell
      ];

      programs.dank-material-shell = {
        lockscreen.securityKey.enable = true;
      };
    };
    home = {
      imports = [
        inputs.dms.homeModules.dank-material-shell
      ];

      programs.dank-material-shell = {
        enable = true;
        enableVPN = false;
        enableDynamicTheming = false;
        enableAudioWavelength = false;

        settings = {
          popupTransparency = 0.5;
          foregroundLayerTransparency = 0.5;
          clockFormat = "24h";
          # blurEnabled = true;
          showOccupiedWorkspacesOnly = true;
          niriOverviewOverlayEnabled = false;
          screenPreferences = {
            wallpaper = [ ];
          };

          dashTabs = [
            {
              id = "overview";
              enable = true;
            }
            {
              id = "media";
              enable = true;
            }
            {
              id = "wallpaper";
              enable = false;
            }
            {
              id = "weather";
              enable = true;
            }
            {
              id = "settings";
              enable = false;
            }
          ];

          barConfigs = [
            {
              id = "default";
              name = "Main Bar";
              enabled = true;
              leftWidgets = [
                "workspaceSwitcher"
                "music"
              ];
              centerWidgets = [
                "clock"
              ];
              rightWidgets = [
                "cpuUsage"
                "memUsage"
                "notificationButton"
                {
                  id = "battery";
                  enabled = true;
                  showBatteryPercentOnlyOnBattery = true;
                  showBatteryTime = false;
                  showBatteryPowerDischarging = false;
                  showBatteryPowerCharging = false;
                }
                "controlCenterButton"
              ];
              transparency = 0.5;
              widgetTransparency = 0.5;
              autoHide = true;
              showOnWindowsOpen = true;
              opensOnOverview = true;
              useOverlayLayer = true;
            }
          ];
        };
      };
    };
    compat.provides = [
      {
        target = self.aspects.niri;
        aspect = {
          nixos = {
            systemd.user.services.niri-flake-polkit.enable = false;
          };
          home = {
            imports = [
              inputs.dms.homeModules.niri
            ];
            programs = {
              dank-material-shell = {
                systemd.enable = false;
                niri = {
                  enableKeybinds = false;
                  enableSpawn = true;
                };
              };
              niri.settings = {
                window-rules = [
                  {
                    draw-border-with-background = false;
                  }
                ];
              };
            };
          };
        };
      }
    ];
  };
}
