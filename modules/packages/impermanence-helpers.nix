{
  perSystem =
    { pkgs, ... }:
    let
      persist = pkgs.writeShellScriptBin "persist" ''
        dir="/persist/$(dirname $1)"
        sudo mkdir -p $dir
        sudo cp -r $@ $dir
      '';
      fs-diff-btrfs = pkgs.writeShellScriptBin "fs-diff-btrfs" ''
        cleanup() {
          sudo umount /btrfs_tmp
          sudo rmdir /btrfs_tmp
        }

        trap cleanup EXIT

        sudo mkdir /btrfs_tmp
        sudo mount -o subvol=/ /dev/mapper/crypted /btrfs_tmp

        set -euo pipefail

        OLD_TRANSID=$(sudo btrfs subvolume find-new /btrfs_tmp/root_blank 9999999)
        OLD_TRANSID=$(cut -d' ' -f4- <<< "$OLD_TRANSID")

        sudo btrfs subvolume find-new "/btrfs_tmp/root" "$OLD_TRANSID" |
        sed '$d' |
        cut -f17- -d' ' |
        sort |
        uniq |
        while read path; do
          path="/$path"
          if [ -L "$path" ]; then
            : # The path is a symbolic link, so is probably handled by NixOS already
          elif [ -d "$path" ]; then
            : # The path is a directory, ignore
          else
            echo "$path"
          fi
        done
      '';
    in
    {
      packages.fs-diff-btrfs = fs-diff-btrfs;
      packages.persist = persist;
    };
}
