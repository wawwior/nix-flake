{ self, lib, ... }: {
  flake.aspects.xkb =
    layout':
    let
      layout = builtins.head (lib.splitString "-" layout');
      variant = lib.removePrefix "${layout'}-" layout';
      xkb = {
        inherit layout variant;
      };
    in
    {
      nixos = {

        services.xserver = { inherit xkb; };

        console.useXkbConfig = true;
      };
      compat.provides = [
        {
          target = self.niri;
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
