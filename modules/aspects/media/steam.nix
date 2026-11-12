{ lib, ... }: {
  flake.aspects.steam = {
    nixos = {
      programs.steam.enable = true;

      nixpkgs.config.allowUnfreePackages = [
        "steam"
        "steam-unwrapped"
      ];
    };
    home = {
      preservation.preserveAt."/persist" = {
        directories = [
          ".local/share/Steam"
        ];
      };
    };
  };
}
