{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  home-manager.users =
    with builtins;
    (mapAttrs (
      name: value:
      let
        home = if pkgs.stdenv.isLinux then "/home/${name}" else "/Users/${name}";
      in
      {
        imports = [
          inputs.sops-nix.homeManagerModules.sops
        ];
        sops = {
          age.keyFile = "${home}/.config/sops/age/keys.txt";
          defaultSopsFile = lib.custom.fromTop ".secrets/users/${name}/default.yaml";
        };
      }
    ) config.userSpec.users);

  sops = {
    defaultSopsFile = lib.custom.fromTop ".secrets/hosts/common.yaml";

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets =
      with builtins;
      lib.attrsets.foldlAttrs
        (
          acc: name: value:
          acc // value
        )
        { }
        (
          mapAttrs (name: value: {
            "password-${name}" = {
              sopsFile = lib.custom.fromTop ".secrets/users/${name}/password.yaml";
              key = "hash";
              neededForUsers = true;
            };
          }) config.userSpec.users
        )
      // {
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
