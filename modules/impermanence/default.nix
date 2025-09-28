{
  flake-file.inputs.impermanence.url = "github:nix-community/impermanence";

  flake.modules = {
    nixos.impermanence =
      {
        inputs,
        ...
      }:
      {
        imports = [ inputs.impermanence.nixosModules.impermanence ];
        boot = {
          # use initrd systemd services to make use of tpm backed full disk encryption
          # using `sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+2+7+12 --wipe-slot=tpm2 /dev/nvme0n1p2`
          initrd.systemd.enable = true;
          initrd.systemd.services.rollback = {
            description = "Rollback BTRFS root subvolume to a pristine state";
            wantedBy = [
              "initrd.target"
            ];
            requires = [ "initrd-root-device.target" ];
            after = [
              # LUKS/TPM process
              "cryptsetup.target"
              "initrd-root-device.target"
              "local-fs-pre.target"
            ];
            before = [
              "sysroot.mount"
              "create-needed-for-boot-dirs.service"
            ];
            unitConfig.DefaultDependencies = "no";
            serviceConfig.Type = "oneshot";
            script = ''
              mkdir /btrfs_tmp
              mount /dev/mapper/crypted /btrfs_tmp
              if [[ -e /btrfs_tmp/root ]]; then
                  mkdir -p /btrfs_tmp/old_roots
                  timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
                  mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
              fi

              delete_subvolume_recursively() {
                  IFS=$'\n'
                  for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
                      delete_subvolume_recursively "/btrfs_tmp/$i"
                  done
                  btrfs subvolume delete "$1"
              }

              for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
                  delete_subvolume_recursively "$i"
              done

              btrfs subvolume create /btrfs_tmp/root
              btrfs subvolume delete /btrfs_tmp/root_blank
              btrfs subvolume snapshot -r /btrfs_tmp/root /btrfs_tmp/root_blank

              umount /btrfs_tmp
              rmdir /btrfs_tmp
            '';
          };
        };
        security.sudo.extraConfig = ''
          # rollback results in sudo lectures after each reboot
          Defaults lecture = never
        '';

        environment.persistence."/persist" = {
          hideMounts = true;
          directories = [
            "/etc/NetworkManager/system-connections"
            "/var/cache/powertop"
            "/var/cache/ccache"
            "/var/lib/bluetooth"
            "/var/lib/fprint"
            "/var/lib/NetworkManager"
            "/var/lib/nixos"
            "/var/lib/sbctl"
            "/var/lib/systemd/backlight"
            "/var/lib/zerotier-one"
            "/var/lib/upower"
          ];
          files = [
            "/etc/machine-id"
            "/etc/ssh/ssh_host_ed25519_key"
            "/etc/ssh/ssh_host_ed25519_key.pub"
            "/etc/ssh/ssh_host_rsa_key"
            "/etc/ssh/ssh_host_rsa_key.pub"
            #"/var/lib/systemd/tpm2-srk-public-key.pem"
            #"/var/lib/systemd/tpm2-srk-public-key.tpm2b_public"
          ];
        };
      };
    homeManager.impermanence =
      {
        inputs,
        pkgs,
        ...
      }:
      {
        home.packages = [
          inputs.self.packages.${pkgs.system}.fs-diff-btrfs
          inputs.self.packages.${pkgs.system}.persist
        ];
      };
  };
}
