{ inputs, lib, ... }:
{
  flake-file.inputs = {
    matugen.url = "github:InioX/matugen";
  };
  flake.aspects.matugen =
    {
      source-color ? null,
    }:
    {
      nixos =
        {
          capabilities ? { },
          ...
        }:
        {
          imports = [ inputs.matugen.nixosModules.default ];
          programs.matugen = {
            enable = true;
            source_color = source-color;
          }
          // lib.optionalAttrs (capabilities ? wallpaper) {
            inherit (capabilities) wallpaper;
          };
        };

      home = {
        imports = [ inputs.matugen.nixosModules.default ];
      };
    };
}
