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
            "browser.ctrlTab.sortByRecentlyUsed" = true;

            "privacy.fingerprintingProtection" = true;
            "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
            "privacy.clearOnShutdown_v2.formdata" = true;
            "privacy.clearOnShutdown_v2.siteSettings" = true;

            "browser.aboutwelcome.enabled" = false;
            "zen.welcome-screen.seen" = true;
            "startup.homepage_welcome_url" = "";
            "startup.homepage_welcome_url.additional" = "";

            "zen.urlbar.behavior" = "normal";
          };
        };
        policies = {
          OverrideFirstRunPage = "";
          OverridePostUpdatePage = "";
          DontCheckDefaultBrowser = true;
          NoDefaultBookmarks = true;
          DisableTelemetry = true;
          DisableAppUpdate = true;
          DisableFeedbackCommands = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
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
