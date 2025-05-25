{
  inputs,
  lib,
  ...
}:
{
  imports = lib.flatten [

    inputs.nixos-facter-modules.nixosModules.facter

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

    (lib.custom.fromTop "hosts/common/core")

    (map lib.custom.hostOptional [
      "services/gnome-keyring.nix"

      "services/bluetooth.nix"

      # PONDER_THE_ORB: is this the best way to do this?
      "stylix/catppuccin-mocha"

      "audio-extra.nix"
      "sddm.nix"
      "hyprland.nix"
      "fonts.nix"
      "steam.nix"
      # "flatpak.nix"
    ])
  ];

  facter.reportPath = ./facter.json;

  hostSpec = {
    username = "wawwior";
    hostName = "apollo";
  };

  networking = {
    networkmanager.enable = true;
    enableIPv6 = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
  };

  environment.variables = {
    NVD_BACKEND = "direct";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
  };

  # Should load by default, but doesn't.
  boot.kernelModules = [ "nvidia-uvm" ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
    initrd.systemd.enable = true;
    kernelParams = [ "quiet" ];
    plymouth.enable = true;
  };

  console.useXkbConfig = true;

  services.xserver = {
    xkb = {
      layout = "de";
      variant = "nodeadkeys";
    };
  };

  system.stateVersion = "24.11";
}
