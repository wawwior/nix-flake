{ self, ... }: {
  flake.aspects.cursor =
    {
      size,
    }:
    {
      nixos = {
        environment.variables = {
          XCURSOR_SIZE = toString size;
        };
      };
      home = { pkgs, ... }: {
        home.pointerCursor = {
          enable = true;
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Classic";
          gtk.enable = true;
          x11.enable = true;
          size = builtins.floor (size + 0.5);
        };
      };

      compat.provides = [
        {
          target = self.aspects.niri;
          aspect = {
            home = {
              programs.niri = {
                settings = {
                  environment = {
                    XCURSOR_SIZE = toString size;
                    XCURSOR_THEME = "Bibata-Modern-Classic";
                  };
                };
              };
            };
          };
        }
      ];
    };
}
