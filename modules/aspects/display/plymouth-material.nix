{ self, inputs, ... }: {
  flake-file.inputs = {
    plymouth-material.url = "github:krozzzis/plymouth-theme-material";
  };

  flake.aspects.plymouth-material = {
    includes = [ self.aspects.plymouth ];
    nixos = { pkgs, ... }: {
      imports = [ inputs.plymouth-material.nixosModules.material ];

      boot = {
        plymouth = {
          theme = "material";
          material.settings = {
            font =
              let
                pkg = self.packages.${pkgs.stdenv.hostPlatform.system}.googlesans-flex;
              in
              "${pkg}/share/fonts/googlesans-flex/GoogleSansFlex[opsz,slnt,wdth,wght].ttf";
            fontFamily = "Google Sans Flex";
          };
        };
      };
    };
    compat.provides = [
      {
        target = self.aspects.matugen;
        aspect = {
          nixos = { config, ... }: {
            boot.plymouth = {
              material.settings = {
                palette =
                  with (builtins.mapAttrs (_: color: color.default.color) config.programs.matugen.theme.colors); {
                    background = background;
                    surface = surface_container;
                    outline = outline_variant;
                    accent = primary;
                    inputOutline = primary;
                    input = surface_container_lowest;
                    badge = primary_container;
                    onSurface = on_surface;
                    muted = on_surface_variant;
                  };
              };
            };
          };
        };
      }
    ];
  };
}
