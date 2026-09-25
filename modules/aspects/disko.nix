{
  inputs,
  lib,
  ...
}:
{

  flake-file.inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    preservation = {
      url = "github:nix-community/preservation";
    };
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

      with-luks = name: content: {
        type = "luks";
        name = "crypt-${baseNameOf name}";
        # deployment
        passwordFile = "/tmp/${if single-key then "luks" else (baseNameOf name)}.key";
        settings = {
          allowDiscards = true;
        };
        inherit content;
      };

      single-disk = name: {
        type = "disk";
        device = name;
        content = {
          type = "gpt";
          partitions =
            bootable
            // with-swap
            // {
              root = {
                size = "100%";
                content = (if luks then with-luks name else (_: _)) content.${content-type};
              };
            };
        };
      };

      lvm-part =
        name:
        (if luks then with-luks name else (_: _)) {
          type = "lvm_pv";
          vg = "pool";
        };

      lvm-disk = name: {
        type = "disk";
        device = name;
        content = lvm-part name;
      };

      lvm-boot-disk = name: {
        type = "disk";
        device = name;
        content = {
          type = "gpt";
          partitions = bootable // {
            root = {
              size = "100%";
              content = lvm-part name;
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

      lvm-disks = lib.genAttrs disks' lvm-disk;

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
          ${boot} = boot-disk;
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
        {
          nixos = {

            imports = [ inputs.preservation.nixosModules.default ];

            preservation.enable = true;

            fileSystems = {
              "/nix".neededForBoot = true;
              "/persist".neededForBoot = true;
            };

            services.openssh.hostKeys = [
              {
                type = "ed25519";
                path = "/persist/etc/ssh/ssh_host_ed25519_key";
              }
            ];
          };

          preserve = {
            directories = [
              "/var/log"
            ];
            files = [
              {
                file = "/etc/machine-id";
                inInitrd = true;
              }
            ];
          };

          systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
        }
        (
          { class, aspect-chain }:
          inputs.dendritic.lib.aspects.forward {
            each = [ { } ];
            fromClass = _: "preserve";
            intoClass = _: "__aspects";
            intoPath = _: [
              "preservation"
              "preserveAt"
              "/persist"
            ];
            fromAspect = _: (builtins.head aspect-chain);
          }
        )
        (
          { class, aspect-chain }:
          inputs.dendritic.lib.aspects.forward {
            each = [ (builtins.head aspect-chain) ];
            fromClass = _: "preserve";
            intoClass = _: "__users";
            intoPath = user: [
              "preservation"
              "preserveAt"
              "/persist"
              "users"
              user.name
            ];
            fromAspect = _: _;
          }
        )
      ];
    };
}
