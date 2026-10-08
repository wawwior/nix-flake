{ self, lib, ... }: {
  flake.aspects.fonts =
    fonts':
    let
      fonts = args: if lib.isFunction fonts' then fonts' args else fonts';
    in
    {
      nixos =
        {
          capabilities ? { },
          ...
        }:
        {
          fonts = {
            packages = lib.mapAttrsToList (_: font: font.package) (capabilities.fonts or { });
            fontconfig.defaultFonts = {
              sansSerif = lib.flatten [ capabilities.fonts.sans.name or [ ] ];
              serif = lib.flatten [ capabilities.fonts.serif.name or [ ] ];
              monospace = lib.flatten [ capabilities.fonts.monospace.name or [ ] ];
              emoji = lib.flatten [ capabilities.fonts.emoji.name or [ ] ];
            };
          };
        };

      home =
        {
          capabilities ? { },
          ...
        }:
        {
          gtk = {
            enable = true;
            font = capabilities.fonts.default or { };
          };
        };

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
