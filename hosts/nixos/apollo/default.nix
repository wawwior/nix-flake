{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = lib.flatten [

    # TODO: FIX facter
    # inputs.nixos-facter-modules.nixosModules.facter

    inputs.disko.nixosModules.disko
    (lib.custom.fromTop "hosts/common/disks/lvm-simple.nix")
    {
      _module.args = {
        bootDisk = "/dev/nvme0n1";
        disks = [
          "/dev/sda"
        ];
        withSwap = true;
        swapSize = "16";
      };
    }

    (map lib.custom.fromTop [
      "hosts/common/core"
      "hosts/common/optional/services/openssh.nix"
      # "hosts/common/optional/services/cpufreq.nix"
      # "hosts/common/optional/services/gnome-keyring.nix"
      # "hosts/common/optional/services/thermald.nix"

      # PONDER_THE_ORB: is this the best way to do this?
      "hosts/common/optional/stylix/catppuccin-mocha"

      # "hosts/common/optional/audio.nix"
      # "hosts/common/optional/sddm.nix"
      # "hosts/common/optional/hyprland.nix"
    ])
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  # TODO: FIX facter
  # facter.reportPath = ./facter.json;

  hostSpec = {
    hostName = "apollo";
  };

  networking = {
    networkmanager.enable = true;
    enableIPv6 = true;
  };


  # TODO: FIX nvidia
  # services.xserver.videoDrivers = [ "nvidia" ];
  # 
  # hardware.graphics = {
  #   enable = true;
  # };
  #
  # hardware.nvidia = {
  #   open = true;
  #   modesetting.enable = true;
  # };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
    initrd.systemd.enable = true;
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
