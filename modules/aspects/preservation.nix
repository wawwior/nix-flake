{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.aspects.preservation = {

    nixos = {

      imports = [ inputs.preservation.nixosModules.default ];

      preservation = {
        preserveAt."/persist" = {
          directories = [
            "/var/log"
          ];
          files = [
            {
              file = "/etc/machine-id";
              inInitrd = true;
            }
          ];
        };
        enable = true;
      };

      fileSystems = {
        "/nix".neededForBoot = true;
        "/persist".neededForBoot = true;
      };

      services.openssh.hostKeys = [
        {
          type = "ed25519";
          path = "/persist/etc/ssh/ssh_host_ed25519_key";
        }
      ];

      security.sudo.extraConfig = ''
        Defaults lecture = never
      '';

      systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
    };

    compat.provides = [
      {
        target = self.aspects.home-manager;
        aspect = {
          nixos = { config, ... }: {
            preservation.preserveAt = lib.mkMerge (
              lib.mapAttrsToList (
                name: config':
                lib.mapAttrs (_: preserve: { users.${name} = preserve; }) config'.preservation.preserveAt
              ) config.home-manager.users
            );
          };

          home = {
            options.preservation.preserveAt = lib.mkOption {
              type = lib.types.attrsOf (
                lib.types.submodule {
                  options = {
                    directories = lib.mkOption {
                      type = lib.types.listOf lib.types.anything;
                      default = [ ];
                    };
                    files = lib.mkOption {
                      type = lib.types.listOf lib.types.anything;
                      default = [ ];
                    };
                  };
                }
              );
              default = { };
            };
          };
        };
      }
    ];
  };
}
