{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  hostSpec = config.hostSpec;
  userSpec = config.userSpec;
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.users =
    with builtins;
    (mapAttrs (name: value: {
      name = name;

      hashedPasswordFile = config.sops.secrets."password-${name}".path;

      shell = pkgs.zsh;

      extraGroups =
        value.extraGroups
        ++ (ifTheyExist value.optionalGroups)
        ++ (if value.isWheel then [ "wheel" ] else [ ]);

      isNormalUser = true;
      home = if pkgs.stdenv.isLinux then "/home/${name}" else "/Users/${name}";
    }) userSpec.users)
    // {
      root = {
        shell = pkgs.zsh;
        hashedPasswordFile = config.sops.secrets."password-root".path;
      };
    };

  # users.users.${hostSpec.username} = {
  #   name = hostSpec.username;
  #   home = hostSpec.home;
  #   isNormalUser = true;
  #   shell = pkgs.zsh;
  #   hashedPasswordFile = config.sops.secrets.password-user.path;

  #   extraGroups = lib.flatten [
  #     "wheel"
  #     (ifTheyExist [
  #       "audio"
  #       "networkmanager"
  #       "input"
  #       "git"
  #       "docker"
  #       "gamemode"
  #     ])
  #   ];
  # };

  users.mutableUsers = false;

  home-manager = {
    extraSpecialArgs = {
      inherit inputs pkgs;
    };
    users =
      with builtins;
      (mapAttrs (
        name: value:
        let
          homeDir = if pkgs.stdenv.isLinux then "/home/${name}" else "/Users/${name}";
        in
        {
          home = {
            username = name;
            homeDirectory = homeDir;
            stateVersion = "24.11";
          };
          imports = lib.flatten [
            (
              { config, ... }:
              import (lib.custom.fromTop "home/${name}/${hostSpec.hostName}.nix") {
                inherit
                  inputs
                  pkgs
                  lib
                  config
                  ;
              }

            )
            (
              { ... }:
              {
                homeSpec = {
                  hostName = lib.mkForce hostSpec.hostName;
                  user = {
                    name = lib.mkForce name;
                    home = lib.mkForce homeDir;
                    graphical = lib.mkForce value.graphical;
                  };
                  display = lib.mkForce hostSpec.display;
                  spotifyClientIdPath = lib.mkForce config.sops.secrets.spotify-client-id.path;
                };
              }
            )
          ];
        }
      ) userSpec.users)
      // {
        root = {
          programs.zsh.enable = true;
          home.stateVersion = "24.11";
        };
      };
  };
}
