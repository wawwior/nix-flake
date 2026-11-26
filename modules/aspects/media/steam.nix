{ self, ... }: {
  flake.aspects.steam = {
    nixos = {
      programs.steam.enable = true;

      nixpkgs.config.allowUnfreePackages = [
        "steam"
        "steam-unwrapped"
      ];
    };
    compat.provides = [
      {
        target = self.aspects.preservation;
        aspect = {
          home = {
            preservation.preserveAt."/persist" = {
              directories = [
                ".local/share/Steam"
                # native unity games might put state here
                ".config/unity3d"
              ];
            };
          };
        };
      }
    ];
  };
}
