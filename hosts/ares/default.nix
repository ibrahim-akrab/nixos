# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, modulesPath,  ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.timeout = 4;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = ["v4l2loopback"];
  # boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  boot.extraModprobeConfig =
    ''
    options v4l2loopback exclusive_caps=1
    '';

  networking.hostName = "ares"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Cairo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable Docker
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "ibrahim" ];

  # Enable Virtualbox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "ibrahim" ];


  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb = {
    # layout = "us";
    # variant = "";
  # };

  # Enable bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.firmware = [ pkgs.rtl8761b-firmware ];
  services.blueman.enable = true;


  # Enable CUPS to print documents.
  services.printing.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAtV1FKWG9liaKeoqClebQfFihKakwwu6LX4dl/Ss4fJ ibrahim@nixos" ];

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.jack.loopback.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # disable buzzing sound when inactive for a while
    wireplumber.enable = true;
    wireplumber.extraConfig = {
      "disable-suspension" = {
        "monitor.alsa.rules" = [
          {
            matches = [
              {
                # Match all sources
                "node.name" = "~alsa_input.*";
              }
              {
                 # Match all sinks
                "node.name" = "~alsa_output.*";
              }
            ];
            actions = {
              update-props = {
                "session.suspend-timeout-seconds" = "0";
              };
            };
          }
        ];
        "monitor.bluez.rules" = [
          {
            matches = [
              {
                # Match all sources
                "node.name" = "~bluez_input.*";
              }
              {
                 # Match all sinks
                "node.name" = "~bluez_output.*";
              }
            ];
            actions = {
              update-props = {
                "session.suspend-timeout-seconds" = "0";
              };
            };
          }
        ];
      };
    };

    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ibrahim = {
    isNormalUser = true;
    description = "ibrahim";
    extraGroups = [ "networkmanager" "wheel" "tty" "dialout"];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAtV1FKWG9liaKeoqClebQfFihKakwwu6LX4dl/Ss4fJ ibrahim@nixos" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Enable automatic login for the user.
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "ibrahim";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  # nix.settings.experimental-features = "nix-command flakes";

  # trust my user
  nix.settings.trusted-users = [ "root" "ibrahim" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    docker-compose

    git
    droidcam
    difftastic
    google-chrome
    stremio
    slack
    vscode
    (vscode-with-extensions.override {
      vscode = vscode;
      vscodeExtensions = with vscode-extensions; [
        eamodio.gitlens
        ms-python.vscode-pylance
        ms-python.python
        editorconfig.editorconfig
        vscodevim.vim
        timonwong.shellcheck
      ];
    })
    cht-sh
    vlc
  #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.kdeconnect.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.firefox.enable = true;

  # List services that you want to enable:
  services.cron.enable = true;



  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.channel = "https://channels.nixos.org/nixos-unstable";
}
