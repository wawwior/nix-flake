{
  flake.aspects.bootable = {
    nixos = { pkgs, ... }: {
      boot = {
        loader = {
          timeout = 3;
          efi = {
            canTouchEfiVariables = true;
          };
          systemd-boot = {
            enable = true;
          };
        };
        kernelPackages = pkgs.linuxPackages_latest;
      };
    };
  };
}
