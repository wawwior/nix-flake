{ self, lib, ... }: {
  flake.aspects.xkb =
    layout:
    let
      xkb = {
        layout = builtins.head (lib.splitString "-" layout);
        variant = lib.removePrefix "${xkb.layout}-" layout;
      };
    in
    {
      nixos = {
        services.xserver = { inherit xkb; };

        console.useXkbConfig = true;
      };
      compat.provides = [
        {
          target = self.aspects.niri;
          aspect = {
            home = {
              programs.niri = {
                settings = {
                  input.keyboard = { inherit xkb; };
                };
              };
            };
          };
        }
      ];
    };
}
