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

      "server/minecraft.nix"
      "server/http.nix"

      "audio-extra.nix"
      "scarlett.nix"
      "sddm.nix"
      "hyprland.nix"
      "fonts.nix"
      "steam.nix"
      # "flatpak.nix"
    ])
  ];

  facter.reportPath = ./facter.json;

  hostSpec = {
    hostName = "apollo";
    display = {
      name = "DP-3";
      mode = "1920x1080@119.98";
    };
  };

  userSpec = {
    users = {
      "wawwior" = {
        isWheel = true;
        optionalGroups = [
          "audio"
          "video"
          "networkmanager"
          "input"
          "git"
          "docker"
          "gamemode"
        ];
        graphical = true;
      };
    };
  };

  networking = {
    networkmanager = {
      plugins = with pkgs; [
        networkmanager-openconnect
      ];
      enable = true;
    };
    enableIPv6 = true;
    extraHosts = ''
      35.186.224.24 api.spotify.com
    '';
    firewall.allowedTCPPorts = [ 42420 ];
    firewall.allowedUDPPorts = [ 42420 ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
  };

  # environment.variables = {
  #   NVD_BACKEND = "direct";
  #   LIBVA_DRIVER_NAME = "nvidia";
  #   __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  # };

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
    binfmt.emulatedSystems = [ "aarch64-linux" ];
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
