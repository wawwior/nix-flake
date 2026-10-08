{ lib, ... }: {
  flake.aspects.fontconfig = {
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
  };
}
