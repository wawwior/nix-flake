{ self, ... }: {
  flake.aspects.vesktop = {
    home = {
      programs.vesktop = {
        enable = true;
      };
    };
    compat.provides = [
      {
        target = self.aspects.preservation;
        aspect = {
          home = {
            preservation.preserveAt."/persist" = {
              directories = [
                ".config/vesktop"
              ];
            };
          };
        };
      }
      {
        target = self.aspects.matugen;
        aspect = {
          nixos = {
            programs.matugen.templates.vesktop = {
              input_path = ./vesktop-matugen.css;
              output_path = "~/vesktop-matugen.css";
            };
          };
          home = { config, ... }: {
            programs.vesktop = {
              vencord.settings = {
                themes = {
                  matugen = "${config.matugen.theme.files}/vesktop-matugen.css";
                };
                enabledThemes = [
                  "matugen.css"
                ];
              };
            };
          };
        };
      }
    ];
  };
}
