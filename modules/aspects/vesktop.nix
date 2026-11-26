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
    ];
  };
}
