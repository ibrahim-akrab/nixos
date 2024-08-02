# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

let
  hashedPassword = "$6$bHLwBWJR3ymg.Yo2$eqX0cXWWpeN2UKzpHZAPBEVFpm1S9EVUw2uX8kyS6uFV./o3SRFgqBP7UKUsLKJ3T7HtLDPwWugM/rlHalel4/"; # mkpasswd -m sha-512
  sshkeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAey37St4eX4Y7Em3tW0L8jFnQvEWilcbHQxeqkB9Yf+ ibrahim@ibrahim-deskto" ];
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./disko.nix
      ./nbfc.nix
      inputs.hardware.nixosModules.common-cpu-intel
      inputs.hardware.nixosModules.common-pc-laptop
      inputs.hardware.nixosModules.common-pc-laptop-acpi_call
      inputs.hardware.nixosModules.common-pc-laptop-ssd
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # delete root on boot
  boot.initrd = {
    enable = true;
    supportedFilesystems = [ "btrfs" ];
    postResumeCommands = lib.mkAfter ''
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
      btrfs subvolume snapshot -r /btrfs_tmp/root /btrfs/root-blank

      umount /btrfs_tmp
      rmdir /btrfs_tmp
    '';
  };


  networking.hostName = "apollo"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Africa/Cairo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # use KDE plasma with wayland
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;


  security.sudo.extraConfig = ''
    # rollback results in sudo lectures after each reboot
    Defaults lecture = never
  '';



  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # nix configuration
  nix = {
    package = pkgs.nixVersions.nix_2_22;
    settings = {
      trusted-users = [
        "root"
        "@wheel"
      ];
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  # Don't allow mutation of users outside of the config.
  users.mutableUsers = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ibrahim = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "tty" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = sshkeys;
    hashedPassword = hashedPassword;
    # packages = with pkgs; [
    #   firefox
    #   tree
    # ];
  };
  users.users.root = {
    hashedPassword = hashedPassword;
    openssh.authorizedKeys.keys = sshkeys;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    (writeShellScriptBin "persist" ''
      dir="/persist/$(dirname $1)"
      sudo mkdir -p $dir
      sudo cp -r $@ $dir
    '')
    (writeShellScriptBin "fs-diff" ''
      cleanup() {
        sudo umount /btrfs_tmp
        sudo rmdir /btrfs_tmp
      }

      trap cleanup EXIT

      sudo mkdir /btrfs_tmp
      sudo mount -o subvol=/ /dev/mapper/crypted /btrfs_tmp

      set -euo pipefail

      OLD_TRANSID=$(sudo btrfs subvolume find-new /btrfs_tmp/root-blank 9999999)
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
    '')
  ];
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/lib/NetworkManager"
      "/var/lib/nixos"
      "/var/lib/fprint"
    ];
    files = [
      "/etc/machine-id"
    ];

  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.hyprland = {
  #   enable = true;
  #   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  # };
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.acpid.enable = true;
  services.fprintd.enable = true;
  services.hardware.bolt.enable = true;
  powerManagement.enable = true;
  powerManagement.powertop.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
