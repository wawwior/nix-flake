{ inputs, lib, ... }: {

  flake-file.inputs = {
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.aspects.disko =
    {
      disks ? [ ],
      swap ? null,
      efi ? true,
    }:
    let
      boot = builtins.head disks;
      disks' = lib.drop 1 disks;
    in
    {
      name = "disko";

      nixos = {
        imports = [
          inputs.disko.nixosModules.disko
        ];

        disko.devices = {
          lvm_vg = {
            pool = {
              type = "lvm_vg";
              lvs = {
                root = {
                  size = "100%FREE";
                  content = {
                    type = "filesystem";
                    format = "ext4";
                    mountpoint = "/";
                    mountOptions = [
                      "defaults"
                    ];
                  };
                };
              };
            };
          };
          disk =
            builtins.foldl' lib.recursiveUpdate
              {
                ${boot} = {
                  device = boot;
                  type = "disk";
                  content = {
                    type = "gpt";
                    partitions = {
                      boot = lib.mkIf (!efi) {
                        name = "BOOT";
                        size = "1M";
                        type = "EF02";
                      };
                      esp = {
                        name = "ESP";
                        size = "500M";
                        type = "EF00";
                        content = {
                          type = "filesystem";
                          format = "vfat";
                          mountpoint = "/boot";
                          mountOptions = [ "umask=0077" ];
                        };
                      };
                      swap = lib.mkIf (swap != null) {
                        size = swap;
                        content = {
                          type = "swap";
                          discardPolicy = "both";
                          resumeDevice = true;
                        };
                      };
                      primary = {
                        size = "100%";
                        content = {
                          type = "lvm_pv";
                          vg = "pool";
                        };
                      };
                    };
                  };
                };
              }
              (
                map (disk: {
                  ${disk} = {
                    device = disk;
                    type = "disk";
                    content = {
                      type = "lvm_pv";
                      vg = "pool";
                    };
                  };
                }) disks'
              );
        };
      };
    };

}
