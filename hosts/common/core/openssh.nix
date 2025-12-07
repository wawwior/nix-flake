{ lib, config, ... }:
{
  services.openssh = {
    enable = true;

    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };

    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  users.users =
    with builtins;
    (mapAttrs (name: value: {
      openssh.authorizedKeys.keys = [
        (readFile (lib.custom.fromTop ".ssh/${name}/id_auth_ed25519_key.pub"))
      ];
    }) config.userSpec.users);

}
