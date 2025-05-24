{
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  home-manager.users.${config.hostSpec.username} = {
    imports = [
      inputs.sops-nix.homeManagerModules.sops
    ];
    sops = {
      age.keyFile = "/home/${config.hostSpec.username}/.config/sops/age/keys.txt";
      defaultSopsFile = lib.custom.fromTop ".secrets/users/${config.hostSpec.username}/default.yaml";
    };
  };

  sops = {
    defaultSopsFile = lib.custom.fromTop ".secrets/hosts/common.yaml";

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      password-user = {
        sopsFile = lib.custom.fromTop ".secrets/users/${config.hostSpec.username}/password.yaml";
        key = "hash";
        neededForUsers = true;
      };
      password-root = {
        sopsFile = lib.custom.fromTop ".secrets/hosts/${config.hostSpec.hostName}/default.yaml";
        key = "passwords/root";
        neededForUsers = true;
      };
      "tokens/github" = { };
    };

    templates = {
      "nix-access-tokens.conf" = {
        content = ''
          access-tokens = github.com=${config.sops.placeholder."tokens/github"}
        '';
      };
    };
  };
}
