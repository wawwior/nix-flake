{
  lib,
  bootDisk ? "/dev/vda",
  disks ? [ ],
  withSwap ? false,
  swapSize,
  ...
}:
let
  mkBootDisk = disk: {
    ${disk} = {
      type = "disk";
      device = "${disk}";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            type = "EF00";
            size = "500M";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          swap = lib.mkIf withSwap {
            size = "${swapSize}G";
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
              vg = "mainpool";
            };
          };
        };
      };
    };
  };

  mkDisk = disk: {
    ${disk} = {
      type = "disk";
      device = "${disk}";
      content = {
        type = "lvm_pv";
        vg = "mainpool";
      };
    };
  };

  mkDisks =
    _disks: _bootDisk:
    lib.foldl (acc: set: acc // set) (mkBootDisk _bootDisk) (lib.map (disk: mkDisk disk) _disks);
in
{
  disko.devices = {
    disk = mkDisks disks bootDisk;
    lvm_vg = {
      mainpool = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%";
            pool = "mainpool";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
