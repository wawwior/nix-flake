{ config, ... }:
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

  home.file = {
    ".ssh/sockets/.keep".text = "# Managed by home-manager";
  };
}
