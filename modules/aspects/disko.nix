{
  self,
  inputs,
  lib,
  ...
}:
{

  flake-file.inputs = {
    disko.url = "github:nix-community/disko";
    preservation.url = "github:nix-community/preservation";
  };

  flake.aspects.disko =
    {
      disks ? [ ],
      swap ? null,
      efi ? true,
      esp-size ? "500M",
      luks ? false,
      file-system ? "auto",
      impermanence ? false,
      single-key ? true,
    }:
    let
      boot = builtins.head disks;
      disks' = lib.drop 1 disks;

      use-lvm = disks' != [ ] || luks;

      content-type = if impermanence then "impermanence" else "default";

      content = {
        impermanence =
          assert builtins.elem file-system [
            "auto"
            "btrfs"
          ];
          {
            type = "btrfs";
            extraArgs = [ "-f" ];

            subvolumes = {
              "/persist" = {
                mountOptions = [ "noatime" ];
                mountpoint = "/persist";
              };
              "/nix" = {
                mountOptions = [ "noatime" ];
                mountpoint = "/nix";
              };
            };
          };
        default =
          # TODO: respect file-system option
          assert builtins.elem file-system [
            "auto"
            "ext4"
          ];
          {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
            mountOptions = [ "defaults" ];
          };
      };

      bootable = {
        boot = lib.mkIf (!efi) {
          name = "BOOT";
          size = "1M";
          type = "EF02";
        };
        esp = {
          name = "ESP";
          size = esp-size;
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };
      };

      with-luks = disk: content: {
        type = "luks";
        name = "crypt-${disk.name}";
        # deployment
        passwordFile = "/tmp/${if single-key then "luks" else (disk.name)}.key";
        settings = {
          allowDiscards = true;
        };
        inherit content;
      };

      single-disk = disk: {
        inherit (disk) device;
        type = "disk";
        content = {
          type = "gpt";
          partitions =
            bootable
            // with-swap
            // {
              root = {
                size = "100%";
                content = (if luks then with-luks disk else (_: _)) content.${content-type};
              };
            };
        };
      };

      lvm-part =
        disk:
        (if luks then with-luks disk else (_: _)) {
          type = "lvm_pv";
          vg = "pool";
        };

      lvm-disk = disk: {
        inherit (disk) device;
        type = "disk";
        content = lvm-part disk;
      };

      lvm-boot-disk = disk: {
        inherit (disk) device;
        type = "disk";
        content = {
          type = "gpt";
          partitions = bootable // {
            root = {
              size = "100%";
              content = lvm-part disk;
            };
          };
        };
      };

      lvm-pool = {
        type = "lvm_vg";
        lvs = with-swap // {
          root = {
            size = "100%";
            content = content.${content-type};
          };
        };
      };

      with-swap = {
        swap = lib.mkIf (swap != null) {
          size = swap;
          content = {
            type = "swap";
            discardPolicy = "both";
            resumeDevice = true;
          };
        };
      };

      boot-disk = (if use-lvm then lvm-boot-disk else single-disk) boot;
      lvm-disks = lib.listToAttrs (map (disk: lib.nameValuePair disk.name (lvm-disk disk.device)) disks');

      devices = {
        nodev = lib.mkIf impermanence {
          "/" = {
            fsType = "tmpfs";
            mountOptions = [
              "size=25%"
              "mode=755"
            ];
          };
        };
        lvm_vg = lib.mkIf use-lvm {
          pool = lvm-pool;
        };
        disk = {
          ${boot.name} = boot-disk;
        }
        // lvm-disks;
      };

    in
    {
      name = "disko";

      nixos = {

        imports = [ inputs.disko.nixosModules.disko ];

        disko = {
          inherit devices;
        };
      };

      includes = lib.optionals impermanence [
        self.aspects.preservation
      ];
    };
}
