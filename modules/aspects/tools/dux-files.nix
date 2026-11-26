{ self, inputs, ... }: {
  flake-file.inputs = {
    dux-files.url = "github:duxlabs-dev/dux-files";
  };

  flake.aspects.dux-files = {
    includes = [ self.aspects.dms-colors ];
    home = {
      imports = [ inputs.dux-files.homeModules.default ];

      programs.dux-files = {
        enable = true;

        portal = {
          enable = true;
          preferred = true;
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
          home = { config, ... }: {
            programs.dux-files.settings = {
              colorSource = "custom";
              customThemeFile = "${config.programs.matugen.theme.files}/dms-colors.json";
            };
          };
        };
      }
      {
        target = self.aspects.niri;
        aspect = {
          home = {
            programs.dux-files = {
              portal = {
                desktop = "niri";
              };
            };
          };
        };
      }
    ];
  };
}
