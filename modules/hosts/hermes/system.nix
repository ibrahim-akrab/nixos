{
  flake.modules.nixos.hermes =
    { hostConfig, lib, pkgs, ... }:
    {
      boot.initrd.luks.devices.hermes-root = {
        device = "/dev/disk/by-uuid/0d24b87b-56aa-46a4-8c82-8b6648ce68e7";
        bypassWorkqueues = true;
      };
      boot.growPartition = false;
      fileSystems."/" = {
        device = lib.mkForce "/dev/mapper/hermes-root";
        fsType = "ext4";
        autoResize = false;
      };
      networking.hostName = hostConfig.name;
      networking.networkmanager.enable = true;
      mobile.adbd.enable = true;
      services.openssh.enable = true;
      environment.systemPackages = [ pkgs.btop ];
      home-manager.users.ibrahim.programs.btop.settings.net_iface = lib.mkForce "wlp1s0";
      systemd.services."getty@tty1".enable = false;
      services.greetd = {
        enable = true;
        settings = {
          terminal.vt = 1;
          default_session = {
            user = "ibrahim";
            command = "${pkgs.btop}/bin/btop --tty --update 1000";
          };
        };
      };
      users.users.ibrahim.extraGroups = [ "dialout" "feedbackd" ];
    };
}
