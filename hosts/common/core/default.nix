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

  home-manager.backupFileExtension = "hm-backup";

  nixpkgs = {
    overlays = [
      outputs.overlays.default
    ];
  };

  # basic shell for root
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Berlin";
}
