{
  inputs,
  outputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = lib.flatten [
    inputs.home-manager.nixosModules.home-manager

    ./sops.nix
    ./gnupg.nix
    ./nh.nix
    ./kernel.nix
    ./nix-conf.nix

    (map lib.custom.fromTop [
      "modules/common"
      "hosts/common/users/primary"
    ])
  ];

  hostSpec = {
    username = "wawwior";
  };

  networking.hostName = config.hostSpec.hostName;

  environment.systemPackages = [
    pkgs.openssh
  ];

  services.xserver.updateDbusEnvironment = true;

  home-manager.backupFileExtension = "bk";

  nixpkgs = {
    overlays = [
      outputs.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };

  # basic shell for root
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Berlin";
}
