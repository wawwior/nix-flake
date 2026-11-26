{ self, ... }: {
  flake.aspects.dms-colors = {
    compat.provides = [
      {
        target = self.aspects.matugen;
        aspect = {
          nixos = {
            programs.matugen.templates.dms-colors = {
              input_path = ./dms-colors.json;
              output_path = [ "~/dms-colors.json" ];
            };
          };
        };
      }
    ];
  };
}
