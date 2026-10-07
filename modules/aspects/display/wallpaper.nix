{ self, ... }: {
  flake.aspects.wallpaper = { url, hash }: {
    compat.provides = [
      {
        target = self.aspects.capabilities;
        aspect = {
          nixos = { pkgs, ... }: {
            capabilities.wallpaper = pkgs.fetchurl {
              inherit url hash;
            };
          };
          home = { pkgs, ... }: {
            capabilities.wallpaper = pkgs.fetchurl {
              inherit url hash;
            };
          };
        };
      }
    ];
  };
}
