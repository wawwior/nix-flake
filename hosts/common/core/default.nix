{
  inputs,
  outputs,
  lib,
  config,
  ...
}:
{
  imports = lib.flatten [
    inputs.home-manager.nixosModules.home-manager

    ./kernel.nix
    ./sops.nix
    ./openssh.nix
    ./tmux.nix
    ./nix-conf.nix
    ./nh.nix

    (map lib.custom.fromTop [
      "modules/common"
      "hosts/common/users/primary"
    ])
  ];

  networking.hostName = config.hostSpec.hostName;

  services.xserver.updateDbusEnvironment = true;

  home-manager.backupFileExtension = "bk";

  nixpkgs = {
    overlays = [
      outputs.overlays.default
    ];
    config.allowUnfree = true;
  };

  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  # basic shell for root
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Berlin";
}
