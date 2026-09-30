{
  self,
  inputs,
  lib,
  ...
}:
{
  flake-file.inputs = {
    dms.url = "github:AvengeMedia/DankMaterialShell";
  };
  flake.aspects.dms-shell = {
    nixos = {
      imports = [
        inputs.dms.nixosModules.dank-material-shell
      ];

      services = {
        upower.enable = true;
        power-profiles-daemon.enable = true;
      };

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
          appDrawerSectionViewModes = {
            apps = "list";
          };
          avatarRing = "none";
          barConfigs = [
            {
              autoHide = true;
              autoHideDelay = 250;
              barLengthMode = "full";
              borderColor = "surfaceText";
              borderEnabled = false;
              borderOpacity = 1;
              borderThickness = 1;
              bottomGap = 0;
              centerWidgets = [ "clock" ];
              enabled = true;
              followInterfaceStyle = true;
              fontScale = 1;
              gothCornerRadiusOverride = false;
              gothCornerRadiusValue = 12;
              gothCornersEnabled = false;
              id = "default";
              innerPadding = 4;
              leftWidgets = [
                {
                  enabled = true;
                  id = "workspaceSwitcher";
                  showOccupiedWorkspacesOnly = true;
                  workspaceIndicatorStyle = "pills";
                }
                "music"
              ];
              name = "Main Bar";
              noBackground = false;
              openOnOverview = true;
              popupGapsAuto = true;
              popupGapsManual = 4;
              position = 0;
              rightWidgets = [
                "cpuUsage"
                "memUsage"
                "battery"
                "controlCenterButton"
              ];
              screenPreferences = [ "all" ];
              showOnLastDisplay = true;
              showOnWindowsOpen = true;
              spacing = 4;
              squareCorners = false;
              transparency = 1;
              useOverlayLayer = true;
              visible = true;
              widgetFollowInterfaceStyle = true;
              widgetTransparency = 1;
            }
          ];
          barElevationEnabled = false;
          blurBorderSeeded = true;
          blurEnabled = true;
          builtInPluginSettings = {
            dms_clipboard_search = {
              trigger = "cb";
            };
            dms_power = {
              trigger = "pw";
            };
            dms_qr_generator = {
              trigger = "qrg";
            };
            dms_settings_search = {
              trigger = "?";
            };
          };
          configVersion = 34;
          controlCenterWidgets = [
            {
              background = true;
              badge = true;
              compositor = false;
              enabled = true;
              h = 1.5;
              hostname = true;
              id = "userCard";
              uptime = true;
              w = 6.5;
            }
            {
              actions = [
                {
                  enabled = true;
                  id = "lock";
                }
                {
                  enabled = true;
                  id = "power";
                }
                {
                  enabled = true;
                  id = "settings";
                }
                {
                  enabled = true;
                  id = "edit";
                }
              ];
              enabled = true;
              h = 1.5;
              id = "quickActions";
              powerAccent = false;
              w = 1.5;
            }
            {
              enabled = true;
              h = 1;
              id = "volumeSlider";
              w = 4;
            }
            {
              enabled = true;
              h = 1;
              id = "brightnessSlider";
              w = 4;
            }
            {
              enabled = true;
              h = 1;
              id = "wifi";
              w = 4;
            }
            {
              enabled = true;
              h = 1;
              id = "bluetooth";
              w = 4;
            }
            {
              enabled = true;
              h = 1;
              id = "audioOutput";
              w = 4;
            }
            {
              enabled = true;
              h = 1;
              id = "audioInput";
              w = 4;
            }
            {
              enabled = true;
              h = 1;
              id = "nightMode";
              w = 4;
            }
            {
              enabled = true;
              h = 1;
              id = "doNotDisturb";
              w = 4;
            }
          ];
          dashCards = [
            {
              col = 0;
              h = 1;
              id = "clock";
              row = 0;
              w = 3;
            }
            {
              col = 3;
              h = 4;
              id = "notifications";
              row = 0;
              w = 3;
            }
            {
              col = 0;
              h = 3;
              id = "calendar";
              row = 1;
              w = 3;
            }
          ];
          dashOptions = {
            clock = {
              seconds = true;
            };
            notifications = {
              panelRows = 4;
            };
            overview = {
              panelRows = 4;
            };
          };
          dashTabs = [
            {
              enabled = true;
              id = "overview";
            }
            {
              enabled = false;
              id = "media";
            }
            {
              enabled = false;
              id = "wallpaper";
            }
            {
              enabled = true;
              id = "weather";
            }
            {
              enabled = false;
              id = "notifications";
            }
          ];
          dmsWindowsFloatingSeeded = [ "niri" ];
          dockConfigs = [
            {
              autoHide = false;
              borderColor = "surfaceText";
              borderEnabled = false;
              borderOpacity = 1;
              borderThickness = 1;
              bottomGap = 0;
              editOnRightClick = false;
              enabled = false;
              followInterfaceStyle = true;
              groupByApp = false;
              iconSize = 40;
              id = "dock";
              indicatorStyle = "circle";
              isolateDisplays = false;
              itemSpacing = 4;
              launcherEnabled = false;
              launcherLogoBrightness = 0.5;
              launcherLogoColorOverride = "";
              launcherLogoContrast = 1;
              launcherLogoCustomPath = "";
              launcherLogoMode = "apps";
              launcherLogoSizeOffset = 0;
              margin = 0;
              maxVisibleApps = 0;
              maxVisibleRunningApps = 0;
              mode = "compact";
              name = "Dock";
              openOnOverview = false;
              order = [ ];
              position = 1;
              restoreSpecialWorkspaceOnClick = false;
              screenPreferences = [ "all" ];
              separatePinnedAndRunningApps = false;
              showOnFullscreen = false;
              showOnLastDisplay = true;
              showOverflowBadge = true;
              showTrash = false;
              smartAutoHide = false;
              spacing = 4;
              taskbarAlign = "center";
              transparency = 1;
              trashCustomCommand = "";
              trashFileManager = "default";
              useOverlayLayer = false;
              widgetExpansion = "popout";
              widgets = [
                {
                  enabled = true;
                  id = "dock_launcher";
                  widgetId = "dockLauncher";
                }
                {
                  enabled = true;
                  id = "dock_apps";
                  widgetId = "appsDock";
                }
                {
                  enabled = true;
                  id = "dock_trash";
                  widgetId = "dockTrash";
                }
              ];
            }
          ];
          foregroundLayerTransparency = 0.5;
          networkPreference = "ethernet";
          niriOverviewOverlayEnabled = false;
          popupTransparency = 0.65;
          screenPreferences = {
            lockScreen = [ "all" ];
            wallpaper = [ ];
          };
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
                  includes.enable = false;
                  enableKeybinds = false;
                  enableSpawn = true;
                };
              };
              niri.settings = {
                window-rules = [
                  {
                    geometry-corner-radius = lib.genAttrs [
                      "bottom-left"
                      "bottom-right"
                      "top-left"
                      "top-right"
                    ] (_: 16.0);
                    clip-to-geometry = true;
                    tiled-state = true;
                    draw-border-with-background = false;
                  }
                  {
                    matches = [
                      {
                        app-id = "^com.danklinux.dms$";
                      }
                    ];
                    background-effect.xray = false;
                  }
                ];
                layer-rules = [
                  {
                    background-effect.xray = false;
                  }
                ];
                recent-windows.highlight.corner-radius = 16;
                layout = {
                  gaps = 4;
                  border = {
                    width = 4;
                  };
                  focus-ring = {
                    width = 2;
                  };
                };
              };
            };
          };
        };
      }
    ];
  };
}
