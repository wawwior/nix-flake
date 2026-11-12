{ lib, ... }: {
  flake.aspects.steam = {
    nixos = {
      programs.steam.enable = true;

      nixpkgs.config.allowUnfreePredicate = (
        pkg:
        builtins.elem (lib.getName pkg) [
          "steam"
        ]
      );
    };
  };
}
