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
          nixos = { pkgs, ... }: {
            programs.matugen.templates = {
              zen-userchrome = {
                input_path = pkgs.fetchurl {
                  url = "https://raw.githubusercontent.com/InioX/matugen-themes/b195aa8ea4c362beb911e25cb7d174205bd89293/templates/zen-userchrome.css";
                  sha256 = "0lrslnmvzjvabdaw6264szxn9xd72rw2pfwhhr8y9cbnhbvcjvcj";
                };
                output_path = "~/zen-userchrome.css";
              };
              zen-usercontent = {
                input_path = pkgs.fetchurl {
                  url = "https://raw.githubusercontent.com/InioX/matugen-themes/b195aa8ea4c362beb911e25cb7d174205bd89293/templates/zen-usercontent.css";
                  sha256 = "1dllg0q0zqdb8winj86z430y3zrsisbayi6wvazpagc3sh339ac4";
                };
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
