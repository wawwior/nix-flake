{
  inputs,
  lib,
  ...
}:
{
  imports = lib.flatten [

    inputs.nixos-facter-modules.nixosModules.facter

    ./filesystem.nix

    (map lib.custom.fromTop [
      "hosts/common/core"
      "hosts/common/optional/services/openssh.nix"
      "hosts/common/optional/services/cpufreq.nix"
      "hosts/common/optional/services/gnome-keyring.nix"
      "hosts/common/optional/services/thermald.nix"

      # PONDER_THE_ORB: is this the best way to do this?
      "hosts/common/optional/stylix/catppuccin-mocha"

      "hosts/common/optional/audio.nix"
      "hosts/common/optional/sddm.nix"
      "hosts/common/optional/hyprland.nix"
    ])
  ];

  facter.reportPath = ./facter.json;

  hostSpec = {
    hostName = "apollo";
  };

  networking = {
    networkmanager.enable = true;
    enableIPv6 = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
  };

  boot = {
    loader = {
      grub.device = "nodev";
    };
  };

  system.stateVersion = "24.11";

  console.useXkbConfig = true;

  services.xserver = {
    xkb = {
      layout = "de";
      variant = "nodeadkeys";
    };
  };
}
