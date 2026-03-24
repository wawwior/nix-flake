{
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {

    enable = true;
    setAsDefaultBrowser = true;

    profiles = {
      "${config.homeSpec.user.name}" = {
        extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          proton-pass
          mullvad
          istilldontcareaboutcookies
        ];
        search = {
          force = true;
          default = "ddg";
          engines = { };
        };

        settings = {
          zen.pinned-tab-manager.close-shortcut-behavior = true;
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
}
