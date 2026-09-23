{ lib, ... }: {
  flake.aspects.nvidia =
    {
      package ? "default",
      open ? false,
      prime ? null,
    }:
    {
      name = "nvidia";

      nixos =
        { config, ... }:
        let
          packages = {
            latest = config.boot.kernelPackages.nvidiaPackages.latest;
            legacy = config.boot.kernelPackages.nvidiaPackages.legacy_580;
          };
        in
        {
          services.xserver.videoDrivers = [ "nvidia" ];

          hardware.graphics.enable = true;

          hardware.nvidia = {
            inherit open;
            package = lib.mkIf (package != "default") packages.${package};
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

          nixpkgs.config.allowUnfreePredicate = (
            pkg:
            builtins.elem (lib.getName pkg) [
              "nvidia-x11"
              "nvidia-settings"
              "nvidia-kernel-modules"
            ]
          );
        };
    };
}
