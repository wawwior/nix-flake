{
  flake.aspects.noctalia-niri = {
    home = {
      programs.niri.settings = {
        spawn-at-startup = [
          {
            command = "noctalia";
          }
        ];
        window-rules = [
          {
            matches = [
              {
                app-id = "dev.noctalia.Noctalia";
              }
            ];
            open-floating = true;
            default-column-width = {
              fixed = 1080;
            };
            default-window-height = {
              fixed = 920;
            };
            background-effect = {
              blur = true;
              xray = false;
            };
          }
          {
            background-effect = {
              blur = true;
              xray = false;
            };
          }
        ];
        layer-rules = [
          {
            matches = [
              {
                namespace = "^noctalia-wallpaper";
              }
            ];
            place-within-backdrop = true;
          }
          {
            matches = [
              {
                namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";
              }
            ];
            background-effect = {
              xray = false;
            };
          }
        ];
        blur = {
          passes = 2;
          offset = 3.0;
          noise = 0.03;
          saturation = 1.0;
        };
        # switch-events = {
        #   lid-close = {
        #     spawn = [
        #       "noctalia"
        #       "msg"
        #       "session"
        #       "lock-and-suspend"
        #     ];
        #   };
        # };
        layout.background-color = "transparent";
      };
    };
  };
}
