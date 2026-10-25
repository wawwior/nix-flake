{
  self,
  inputs,
  lib,
  ...
}:
{
  flake-file.inputs = {
    dms.url = "github:duxlabs-dev/dux-shell";
  };
  flake.aspects.dms-shell = {
    includes = with self.aspects; [
      upower
      power-profiles-daemon
    ];
    nixos = {
      imports = [
        inputs.dms.nixosModules.dank-material-shell
      ];

      programs.dank-material-shell = {
        enable = true;
        enableVPN = false;
        enableAudioWavelength = false;
        lockscreen.securityKey.enable = true;
        systemd = {
          enable = true;
          restartIfChanged = true;
        };
      };
    };
    home =
      {
        config,
        pkgs,
        ...
      }:
      let
        capabilities = config.capabilities or { };
      in
      {
        imports = [
          inputs.dms.homeModules.dank-material-shell
        ];

        xdg.configFile."dms/.changelog-2.0".source = pkgs.writeText ".changelog-2.0" ''
          2.0
        '';

        programs.dank-material-shell = {
          enable = true;
          enableVPN = false;
          enableAudioWavelength = false;

          session = lib.optionalAttrs (capabilities ? wallpaper) {
            wallpaperPath = "${capabilities.wallpaper}";
          };

          settings = {
            appDrawerSectionViewModes = {
              apps = "list";
            };
            audioVisualizerEnabled = false;
            avatarRing = "none";
            barConfigs = [
              {
                autoHide = false;
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
                    id = "launcherButton";
                    launcherLogoColorOverride = "";
                    launcherLogoMode = "os";
                    launcherLogoSizeOffset = 2;
                  }
                  {
                    enabled = true;
                    id = "workspaceSwitcher";
                    showOccupiedWorkspacesOnly = true;
                    workspaceIndicatorStyle = "pills";
                  }
                  {
                    enabled = true;
                    id = "music";
                    mediaSize = 2;
                  }
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
                useOverlayLayer = false;
                visible = true;
                widgetFollowInterfaceStyle = true;
                widgetTransparency = 1;
              }
            ];
            barElevationEnabled = false;
            blurBorderSeeded = true;
            blurEnabled = true;
            blurWallpaperOnOverview = true;
            builtInPluginSettings = {
              dms_clipboard_search = {
                enabled = false;
                trigger = "cb";
              };
              dms_colorpicker = {
                enabled = false;
              };
              dms_notepad = {
                enabled = false;
              };
              dms_power = {
                enabled = false;
                trigger = "pw";
              };
              dms_qr_generator = {
                enabled = false;
                trigger = "qrg";
              };
              dms_settings = {
                enabled = false;
              };
              dms_settings_search = {
                enabled = false;
                trigger = "?";
              };
              dms_sysmon = {
                enabled = false;
              };
              dms_vpn = {
                enabled = false;
              };
            };
            configVersion = 42;
            controlCenterWidgets = [
              {
                col = 5;
                enabled = true;
                h = 1;
                id = "settings";
                row = 5;
                small = true;
                w = 1;
              }
              {
                col = 6;
                enabled = true;
                h = 1;
                id = "lock";
                row = 5;
                small = true;
                w = 1;
              }
              {
                col = 7;
                enabled = true;
                h = 1;
                id = "power";
                row = 5;
                small = true;
                w = 1;
              }
              {
                col = 0;
                enabled = true;
                h = 1;
                id = "volumeSlider";
                row = 0;
                w = 8;
              }
              {
                col = 0;
                deviceName = "backlight:intel_backlight";
                enabled = true;
                h = 1;
                id = "brightnessSlider";
                row = 1;
                w = 8;
              }
              {
                col = 0;
                enabled = true;
                h = 1;
                id = "wifi";
                row = 2;
                w = 4;
              }
              {
                col = 4;
                enabled = true;
                h = 1;
                id = "bluetooth";
                row = 2;
                w = 4;
              }
              {
                col = 4;
                enabled = true;
                h = 1;
                id = "audioOutput";
                row = 3;
                w = 4;
              }
              {
                col = 0;
                enabled = true;
                h = 1;
                id = "audioInput";
                row = 3;
                w = 4;
              }
              {
                col = 4;
                enabled = true;
                h = 1;
                id = "nightMode";
                row = 4;
                w = 4;
              }
              {
                col = 0;
                enabled = true;
                h = 1;
                id = "doNotDisturb";
                row = 4;
                w = 4;
              }
              {
                col = 4;
                enabled = true;
                h = 1;
                id = "edit";
                row = 5;
                small = true;
                w = 1;
              }
              {
                col = 0;
                enabled = true;
                h = 1;
                id = "runningApps";
                row = 5;
                small = true;
                w = 4;
              }
            ];
            currentThemeName = lib.mkDefault "dynamic";
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
              media = {
                albumArtBackdrop = false;
                titleFont = "ui";
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
                magnification = false;
                magnificationExpand = false;
                magnificationProfile = "parabolic";
                magnificationScale = 130;
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
            greeterWidgetInstances = [
              {
                config = {
                  autoPosition = false;
                  colorMode = "default";
                  customColor = "#ffffff";
                  displayPreferences = [ "all" ];
                  fontFamily = "";
                  rounded = false;
                  showAnalogNumbers = false;
                  showAnalogSeconds = true;
                  showDate = false;
                  showDigitalSeconds = false;
                  style = "expressive";
                  syncPositionAcrossScreens = true;
                  transparency = 0;
                  twoTone = false;
                  weight = 600;
                };
                enabled = true;
                id = "lock_clock";
                widgetType = "desktopClock";
              }
              {
                config = {
                  colorMode = "default";
                  customColor = "#ffffff";
                  displayPreferences = [ "all" ];
                  format = "short";
                  syncPositionAcrossScreens = true;
                };
                enabled = false;
                id = "lock_date";
                widgetType = "lockDate";
              }
              {
                config = {
                  displayPreferences = [ "all" ];
                  passwordVisibility = "always";
                  profileVisibility = "always";
                  style = "pill";
                  syncPositionAcrossScreens = true;
                };
                enabled = true;
                id = "lock_auth";
                widgetType = "lockAuth";
              }
              {
                config = {
                  background = false;
                  displayPreferences = [ "all" ];
                  showMediaPlayer = true;
                  showWeather = false;
                  syncPositionAcrossScreens = true;
                };
                enabled = true;
                id = "lock_status";
                widgetType = "lockStatus";
              }
              {
                config = {
                  displayPreferences = [ "all" ];
                  shape = "round";
                  syncPositionAcrossScreens = true;
                };
                enabled = false;
                id = "lock_power";
                widgetType = "lockPower";
              }
              {
                config = {
                  colorMode = "default";
                  customColor = "#ffffff";
                  displayPreferences = [ "all" ];
                  format = "short";
                  syncPositionAcrossScreens = true;
                };
                enabled = true;
                id = "lw_1792933096360_2drt8csh9";
                name = "Date";
                widgetType = "lockDate";
              }
              {
                config = {
                  displayPreferences = [ "all" ];
                  syncPositionAcrossScreens = true;
                };
                enabled = true;
                id = "greeter_session";
                widgetType = "greeterSession";
              }
            ];
            launcherPluginVisibility = {
              dms_clipboard_search = {
                allowWithoutTrigger = false;
              };
              dms_power = {
                allowWithoutTrigger = false;
              };
              dms_qr_generator = {
                allowWithoutTrigger = false;
              };
              dms_settings_search = {
                allowWithoutTrigger = false;
              };
              dms_vpn = {
                allowWithoutTrigger = false;
              };
            };
            launcherStyle = "spotlight";
            lockScreenShowWeather = false;
            lockScreenWidgetInstances = [
              {
                config = {
                  autoPosition = false;
                  colorMode = "default";
                  customColor = "#ffffff";
                  displayPreferences = [ "all" ];
                  fontFamily = "";
                  rounded = false;
                  showAnalogNumbers = false;
                  showAnalogSeconds = true;
                  showDate = false;
                  showDigitalSeconds = false;
                  style = "expressive";
                  syncPositionAcrossScreens = true;
                  transparency = 0;
                  twoTone = false;
                  weight = 600;
                };
                enabled = true;
                id = "lock_clock";
                widgetType = "desktopClock";
              }
              {
                config = {
                  colorMode = "default";
                  customColor = "#ffffff";
                  displayPreferences = [ "all" ];
                  format = "short";
                  syncPositionAcrossScreens = true;
                };
                enabled = false;
                id = "lock_date";
                widgetType = "lockDate";
              }
              {
                config = {
                  displayPreferences = [ "all" ];
                  passwordVisibility = "always";
                  profileVisibility = "always";
                  style = "pill";
                  syncPositionAcrossScreens = true;
                };
                enabled = true;
                id = "lock_auth";
                widgetType = "lockAuth";
              }
              {
                config = {
                  displayPreferences = [ "all" ];
                  mode = 2;
                  syncPositionAcrossScreens = true;
                };
                enabled = true;
                id = "lock_notifications";
                widgetType = "lockNotifications";
              }
              {
                config = {
                  background = false;
                  displayPreferences = [ "all" ];
                  showMediaPlayer = true;
                  showWeather = false;
                  syncPositionAcrossScreens = true;
                };
                enabled = true;
                id = "lock_status";
                widgetType = "lockStatus";
              }
              {
                config = {
                  displayPreferences = [ "all" ];
                  shape = "round";
                  syncPositionAcrossScreens = true;
                };
                enabled = false;
                id = "lock_power";
                widgetType = "lockPower";
              }
              {
                config = {
                  colorMode = "default";
                  customColor = "#ffffff";
                  displayPreferences = [ "all" ];
                  format = "short";
                  syncPositionAcrossScreens = true;
                };
                enabled = true;
                id = "lw_1792933096360_2drt8csh9";
                name = "Date";
                widgetType = "lockDate";
              }
            ];
            matugenSpec = "2025";
            modalDarkenBackground = false;
            networkPreference = "ethernet";
            niriOverviewLauncherStyle = "spotlight";
            popupTransparency = 0.7;
            runDmsMatugenTemplates = false;
            runUserMatugenTemplates = false;
            screenPreferences = {
              lockScreen = [ "all" ];
              wallpaper = [ "all" ];
            };
            wellbeingEnabled = false;
          };
        };
      };
    compat.provides = [
      {
        target = self.aspects.matugen;
        aspect = {
          nixos = { pkgs, ... }: {
            programs.matugen.templates.dms-colors = {
              input_path = pkgs.writeText "dms-colors.json" ''
                { <* for name, value in colors *>
                  "{{name}}": "{{value.default.hex}}"<* if not {{ loop.last }} *>,<* endif *><* endfor *>                 
                }
              '';
              output_path = [ "~/dms-colors.json" ];
            };
          };
          home =
            { config, ... }:
            {
              programs.dank-material-shell.settings = {
                currentThemeName = "custom";
                customThemeFile = "${config.programs.matugen.theme.files}/dms-colors.json";
              };
            };
        };
      }
      {
        target = self.aspects.capabilities;
        aspect = {
          home = {
            capabilities.commands.launcher = "dms ipc call spotlight toggle";
          };
        };
      }
      {
        target = self.aspects.niri;
        aspect = {
          nixos = {
            systemd.user.services = {
              niri-flake-polkit.enable = false;
            };
          };
          home =
            {
              pkgs,
              config,
              ...
            }:
            let
              capabilities = config.capabilities or { };
            in
            {
              imports = [
                inputs.dms.homeModules.niri
              ];
              programs = {
                dank-material-shell = {
                  niri = {
                    enableKeybinds = false;
                    enableSpawn = false;
                    includes = {
                      enable = true;

                      override = true;
                      filesToInclude = [
                        "alttab"
                        "cursor"
                        "layout"
                        "outputs"
                        "windowrules"
                        "wpblur"
                      ];
                    };
                  };
                };
                niri.settings = {

                  layout.background-color = "transparent";

                  spawn-at-startup = [
                    {
                      command = [
                        (lib.getExe (
                          pkgs.writeShellApplication {
                            name = "boot-wallpaper";
                            runtimeInputs = [
                              pkgs.swaybg
                              pkgs.niri
                              pkgs.jq
                              pkgs.coreutils
                            ];
                            text = ''
                              swaybg -i ${capabilities.wallpaper} -m fill &
                              pid=$!
                              trap 'kill $pid 2>/dev/null || true' EXIT

                              for _ in $(seq 1 150); do
                                if niri msg --json layers | jq -e 'any(.[]; .layer == "Background" and .namespace != "wallpaper")' > /dev/null; then
                                  sleep 0.5
                                  exit 0
                                fi
                                sleep 0.1
                              done
                            '';
                          }
                        ))
                      ];
                    }
                  ];

                  layer-rules = [
                    {
                      background-effect.xray = false;
                    }
                    {
                      matches = [
                        {
                          namespace = "quickshell";
                        }
                      ];

                      place-within-backdrop = true;
                    }
                  ];

                  window-rules = [
                    {
                      matches = [
                        { app-id = "^com.danklinux.dms$"; }
                      ];
                      background-effect.xray = false;
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
