{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  hashedPassword = "$6$bHLwBWJR3ymg.Yo2$eqX0cXWWpeN2UKzpHZAPBEVFpm1S9EVUw2uX8kyS6uFV./o3SRFgqBP7UKUsLKJ3T7HtLDPwWugM/rlHalel4/"; # mkpasswd -m sha-512
  sshkeys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAey37St4eX4Y7Em3tW0L8jFnQvEWilcbHQxeqkB9Yf+ ibrahim@ibrahim-desktop"];
in {
  imports = [
  ];


  # wsl-specific settings
  wsl.enable = true;
  wsl.defaultUser = "ibrahim";

  networking.hostName = "attis"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Africa/Cairo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Don't allow mutation of users outside of the config.
  users.mutableUsers = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ibrahim = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "tty" "video"]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = sshkeys;
    hashedPassword = hashedPassword;
    packages = with pkgs; [
    ];
  };
  users.users.root = {
    hashedPassword = hashedPassword;
    openssh.authorizedKeys.keys = sshkeys;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  ];

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
  system.stateVersion = "24.11"; # Did you read the comment?
}
