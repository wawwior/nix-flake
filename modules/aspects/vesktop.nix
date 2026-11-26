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
        target = self.aspects.matugen-user;
        aspect = {
          nixos = {
            programs.matugen.templates.vesktop = {
              input_path = ./vesktop-matugen.css;
              output_path = "~/vesktop-matugen.css";
            };
          };
          home = { config, ... }: {
            home.file."${config.xdg.configHome}/vesktop/themes/matugen.css" = {
              source = "${config.programs.matugen.theme.files}/vesktop-matugen.css";
            };
            programs.vesktop = {
              vencord = {
                settings = {
                  enabledThemes = [
                    "matugen.css"
                  ];
                };
              };
            };
          };
        };
      }
    ];
  };
}
