{ self, lib, ... }: {
  flake.aspects.fonts =
    fonts':
    let
      fonts = args: if lib.isFunction fonts' then fonts' args else fonts';
    in
    {
      compat.provides = [
        {
          target = self.aspects.capabilities;
          aspect = {
            home =
              args@{ pkgs, ... }:
              {
                capabilities.fonts = fonts args;
              };
            nixos =
              args@{ pkgs, ... }:
              {
                capabilities.fonts = fonts args;
              };
          };
        }
      ];
    };
}
