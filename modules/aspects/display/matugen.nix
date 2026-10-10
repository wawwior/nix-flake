{ inputs, lib, ... }:
{
  flake-file.inputs = {
    matugen.url = "github:wawwior/matugen";
    matugen-themes = {
      url = "github:InioX/matugen-themes";
      flake = false;
    };
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
            jsonFormat = "hex";
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
