{ self, lib, ... }: {
  flake.aspects.tuigreet = {
    compat.provides = [
      {
        target = self.aspects.capabilities;
        aspect.compat.provides = [
          {
            target = self.aspects.niri;
            aspect.nixos = {
              # TODO: priorities, eventually
              capabilities.tuigreet-cmd = "niri-session";
            };
          }
        ];
      }
    ];
    nixos =
      {
        pkgs,
        capabilities ? { },
        ...
      }:
      {
        services.greetd = {
          enable = true;
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
