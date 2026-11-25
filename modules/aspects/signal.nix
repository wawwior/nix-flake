{ self, ... }: {
  flake.aspects.signal = {
    home = { pkgs, ... }: {
      home.packages = [
        pkgs.signal-desktop
      ];
    };
    compat.provides = [
      {
        target = self.aspects.preservation;
        aspect = {
          home = {
            preservation.preserveAt."/persist" = {
              directories = [
                ".config/Signal"
              ];
            };
          };
        };
      }
    ];
  };
}
