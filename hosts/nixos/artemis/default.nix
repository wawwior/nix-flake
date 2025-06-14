{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = lib.flatten [

    inputs.nixos-facter-modules.nixosModules.facter

    inputs.disko.nixosModules.disko
    (lib.custom.fromTop "hosts/common/disks/ext4-simple.nix")
    {
      _module.args = {
        disk = "/dev/nvme0n1";
        withSwap = true;
        swapSize = "16";
      };
    }

    (lib.custom.fromTop "hosts/common/core")

    (map lib.custom.hostOptional [
      "services/gnome-keyring.nix"

      "services/thermald.nix"
      "services/bluetooth.nix"

      # PONDER_THE_ORB: is this the best way to do this?
      "stylix/catppuccin-mocha"

      "audio.nix"
      "sddm.nix"
      "hyprland.nix"
      "fonts.nix"
      "steam.nix"
    ])
  ];

  facter.reportPath = ./facter.json;

  hostSpec = {
    username = "wawwior";
    hostName = "artemis";
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
    open = false;
    modesetting.enable = true;
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

  environment.systemPackages = [
    pkgs.brightnessctl
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
    initrd.systemd.enable = true;
    kernelParams = [ "quiet" ];
    plymouth.enable = true;
    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };

  console.useXkbConfig = true;

  services.xserver = {
    xkb = {
      layout = "de";
      variant = "nodeadkeys";
    };
  };

  # fprint
  # services.fprintd.enable = true;
  # services.fprintd.tod.enable = true;
  # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-broadcom;

  # systemd.services.fprintd = {
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig.Type = "simple";
  # };

  system.stateVersion = "24.11";
}
