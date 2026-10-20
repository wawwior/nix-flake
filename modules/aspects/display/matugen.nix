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
      colors ? { },
      blend ? true,
    }:
    {
      nixos =
        {
          config,
          ...
        }:
        let
          default-colors = {
            red = "#ec928b";
            orange = "#e49b68";
            yellow = "#c4ad57";
            green = "#80c182";
            cyan = "#45c4bd";
            blue = "#7eb1f3";
            purple = "#c39ae2";
          };
          capabilities = config.capabilities or { };
        in
        {
          imports = [ inputs.matugen.nixosModules.default ];
          programs.matugen = {
            enable = true;
            source_color = source-color;
            jsonFormat = "hex";
            custom_colors =
              lib.genAttrs
                [
                  "red"
                  "orange"
                  "yellow"
                  "green"
                  "cyan"
                  "blue"
                  "purple"
                ]
                (name: {
                  color = (default-colors // colors).${name};
                  inherit blend;
                });
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
