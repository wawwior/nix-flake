{ self, inputs, ... }: {

  flake-file.inputs = {
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  flake.aspects.zen-browser = {
    home = {
      imports = [
        inputs.zen-browser.homeModules.beta
      ];

      programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;
        profiles.default = {
          search = {
            force = true;
            default = "startpage";
          };
          settings = {
            browser.ctrlTab.sortByRecentlyUsed = true;
            privacy = {
              fingerprintingProtection = true;
              clearOnShutdown_v2 = {
                cookiesAndStorage = false;
                formdata = true;
                siteSettings = true;
              };
            };
            zen = {
              welcome-screen.seen = true;
              view = {
                use-single-toolbar = true;
              };
            };
          };
        };
        policies = {
          DisableAppUpdate = true;
          DisableFeedbackCommands = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DontCheckDefaultBrowser = true;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
        };
      };
    };
    compat.provides = [
      {
        target = self.aspects.matugen;
        aspect = {
          nixos = {
            programs.matugen.templates = {
              zen-userchrome = {
                input_path = "${inputs.matugen-themes}/templates/zen-userchrome.css";
                output_path = "~/zen-userchrome.css";
              };
              zen-usercontent = {
                input_path = "${inputs.matugen-themes}/templates/zen-usercontent.css";
                output_path = "~/zen-usercontent.css";
              };
            };
          };
          home = { config, ... }: {
            programs.zen-browser = {
              profiles.default = {
                userChrome = ''@import "${config.programs.matugen.theme.files}/zen-userchrome.css"'';
                userContent = ''@import "${config.programs.matugen.theme.files}/zen-usercontent.css"'';
              };
            };
          };
        };
      }
    ];
  };
}
