{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  hostSpec = config.hostSpec;
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{

  users.users.${hostSpec.username} = {
    name = hostSpec.username;
    home = hostSpec.home;
    isNormalUser = true;
    shell = pkgs.zsh;
    hashedPasswordFile = config.sops.secrets."passwords/${hostSpec.username}".path;

    extraGroups = lib.flatten [
      "wheel"
      (ifTheyExist [
        "audio"
        "networkmanager"
        "input"
        "git"
        "docker"
        "gamemode"
      ])
    ];
  };

  users.users.root = {
    shell = pkgs.zsh;
    hashedPasswordFile = config.sops.secrets."passwords/root".path;
  };

  users.mutableUsers = false;

  home-manager = {
    extraSpecialArgs = {
      inherit inputs pkgs hostSpec;
    };
    users.root = {
      programs.zsh.enable = true;
      home.stateVersion = "24.11";
    };
    users.${hostSpec.username} = {
      home = {
        username = config.hostSpec.username;
        homeDirectory = config.hostSpec.home;
        stateVersion = "24.11";
      };
      imports = lib.flatten [
        (
          { config, ... }:
          import (lib.custom.fromTop "home/${hostSpec.username}/${hostSpec.hostName}.nix") {
            inherit
              inputs
              pkgs
              lib
              config
              hostSpec
              ;
          }
        )
      ];
    };
  };
}
