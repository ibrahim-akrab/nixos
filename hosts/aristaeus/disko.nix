{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                # disable settings.keyFile if you want to use interactive password entry
                #passwordFile = "/tmp/secret.key"; # Interactive
                settings = {
                  allowDiscards = true;
                  # keyFile = "/tmp/secret.key";
                };
                # additionalKeyFiles = [ "/tmp/additionalSecret.key" ];
                content = {
		  type = "zfs";
                  pool = "zroot";
		};
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        rootFsOptions = {
          canmount = "off";
          checksum = "edonr";
          compression = "zstd";
          dnodesize = "auto";
          mountpoint = "none";
          normalization = "formD";
          relatime = "on";
          xattr = "sa";
          "com.sun:auto-snapshot" = "false";
        };
        options = {
          ashift = "12";
          autotrim = "on";
        };
        datasets = {
          # zfs uses cow free space to delete files when the disk is completely filled
          reserved = {
            options = {
              canmount = "off";
              mountpoint = "none";
              reservation = "20GB";
            };
            type = "zfs_fs";
          };
          # dataset where files should persist between boots are stored
          # the Impermanence module is what ensures files are correctly stored here
          persist = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/persist";
            options."com.sun:auto-snapshot" = "false";
            postCreateHook = "zfs snapshot zroot/persist@empty";
          };
	  # users home directory
          home = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/home";
            options."com.sun:auto-snapshot" = "false";
            postCreateHook = "zfs snapshot zroot/home@empty";
          };
          # Nix store etc. Needs to persist, but doesn't need backed up
          nix = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/nix";
            options = {
              atime = "off";
              canmount = "on";
              "com.sun:auto-snapshot" = "false";
            };
            postCreateHook = "zfs snapshot zroot/nix@empty";
          };
          # Where everything else lives, and is wiped on reboot by restoring a blank zfs snapshot.
          root = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            options."com.sun:auto-snapshot" = "false";
            mountpoint = "/";
            postCreateHook = "zfs snapshot zroot/root@empty";
          };
          var-log = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            options."com.sun:auto-snapshot" = "false";
            mountpoint = "/var/log";
            postCreateHook = "zfs snapshot zroot/var-log@empty";
          };
          var-lib = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            options."com.sun:auto-snapshot" = "false";
            mountpoint = "/var/lib";
            postCreateHook = "zfs snapshot zroot/var-lib@empty";
          };
        };
      };
    };
  };

  fileSystems."/persist".neededForBoot = true;
}
