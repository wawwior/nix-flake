{ lib, config, ... }:
{
  programs.ssh =
    let
      authKey = "${config.home.homeDirectory}/.ssh/id_auth_ed25519_key";
    in
    {

      enable = true;
      enableDefaultConfig = false;

      matchBlocks = {
        "*" = {
          controlMaster = "auto";
          controlPath = "${config.home.homeDirectory}/.ssh/sockets/S.%r@%h:%p";
          controlPersist = "20m";
          addKeysToAgent = "yes";
        };
        "github" = {
          host = "github.com gitlab.*";
          user = "git";
          forwardAgent = true;
          identitiesOnly = true;
          identityFile = authKey;
        };
      };

    };

  services.ssh-agent = {
    enable = true;
  };

  home.file =
    let
      pubKey = p: lib.custom.fromTop ".ssh/${config.home.username}" + p;
    in
    {
      ".ssh/sockets/.keep".text = "# Managed by home-manager";
      ".ssh/authorized_keys".source = pubKey "/id_auth_ed25519_key.pub";
      ".ssh/id_auth_ed25519_key.pub".source = pubKey "/id_auth_ed25519_key.pub";
      ".ssh/id_sign_ed25519_key.pub".source = pubKey "/id_sign_ed25519_key.pub";
    };
}
