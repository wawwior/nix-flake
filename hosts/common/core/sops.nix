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

  sops = {
    defaultSopsFile = lib.custom.fromTop "./secrets.yaml";
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      "passwords/wawwior" = {
        neededForUsers = true;
      };
      "passwords/root" = {
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
