{ lib, ... }: {
  flake.aspects.tuigreet = {
    nixos =
      {
        pkgs,
        config,
        ...
      }:
      let
        capabilities = config.capabilitites or { };
      in
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
