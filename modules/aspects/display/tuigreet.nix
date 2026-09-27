{ lib, ... }: {
  flake.aspects.tuigreet = {
    nixos =
      {
        pkgs,
        capabilities ? { },
        ...
      }:
      {
        services.greetd = {
          enable = true;
          useTextGreeter = true;
          settings = {
            default_session = {
              command = lib.concatStringsSep " " [
                "${pkgs.tuigreet}/bin/tuigreet"
                (lib.optionalString (capabilities ? tuigreet-cmd) "--cmd ${capabilities.tuigreet-cmd}")
              ];
            };
          };
        };
      };
  };
}
