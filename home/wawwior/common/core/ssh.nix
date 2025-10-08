{ config, ... }:
{
  programs.ssh =
    let
      authKey = "${config.home.homeDirectory}/.ssh/id_auth_ed25519_key";
    in
    {

      enable = true;

      matchBlocks = {
        "*" = {
          controlMaster = "auto";
          controlPath = "${config.home.homeDirectory}/.ssh/sockets/S.%r@%h:%p";
          controlPersist = "20m";
          addKeysToAgent = "yes";
        };
        "git" = {
          host = "github.com";
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
