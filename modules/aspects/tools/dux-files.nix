{ self, inputs, ... }: {
  flake-file.inputs = {
    dux-files.url = "github:duxlabs-dev/dux-files";
  };

  flake.aspects.dux-files = {
    home = {
      imports = [ inputs.dux-files.homeModules.default ];

      programs.dux-files = {
        enable = true;

        portal = {
          enable = true;
        };

        systemd = {
          enable = true;
        };
      };
    };
    compat.provides = [
      {
        target = self.aspects.matugen;
        aspect = {
          nixos = { pkgs, ... }: {
            programs.matugen.templates.dms-colors = {
              input_path = pkgs.writeText "dms-colors.json" ''
                { <* for name, value in colors *>
                  "{{name}}": "{{value.default.hex}}"<* if not {{ loop.last }} *>,<* endif *><* endfor *>                 
                }
              '';
              output_path = [ "~/dms-colors.json" ];
            };
          };
          home = { config, ... }: {
            programs.dux-files.settings = {
              colorSource = "custom";
              customThemeFile = "${config.programs.matugen.theme.files}/dms-colors.json";
            };
          };
        };
      }
    ];
  };
}
