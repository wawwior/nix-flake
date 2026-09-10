{ lib, ... }: {
  flake.aspects.nvidia =
    {
      latest ? false,
      open ? false,
      prime ? null,
      ...
    }:
    {
      name = "nvidia";

      nixos =
        { config, ... }:
        {
          services.xserver.videoDrivers = [ "nvidia" ];

          hardware.graphics.enable = true;

          hardware.nvidia = {
            inherit open;
            package = lib.mkIf latest config.boot.kernelPackages.nvidiaPackages.latest;
            modesetting.enable = true;
            prime = lib.mkIf (prime != null) {
              intelBusId = prime.intel;
              nvidiaBusId = prime.nvidia;
              offload = {
                enable = true;
                enableOffloadCmd = true;
              };
            };
          };

          boot.kernelModules = [ "nvidia-uvm" ];
        };
    };
}
