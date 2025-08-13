{ config, ... }:
let
  flake.modules.nixos."hosts/apollo".imports =
    with config.flake.modules.nixos;
    [
      # Modules
      apollo-cpu-c-states
      apollo-stateVersion
      apollo-wifi-fix
      audio
      base
      battery
      bluetooth
      desktop
      hyprland
      impermanence
      intel
      laptop
      mixrank
      secure-boot

      # Users
      ibrahim
      root
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users.ibrahim.imports = with config.flake.modules.homeManager; [
          audio
          base
          battery
          desktop
          dev
          hyprland
          impermanence
          laptop
          secure-boot

          #   desktop
          #   dev
          #   facter
          #   shell
          #   thunderbird
        ];
      }
    ];
  apollo-wifi-fix =
    { pkgs, ... }:
    {
      # Fix wifi not working after suspend
      powerManagement.powerDownCommands = "${pkgs.kmod}/bin/modprobe -r iwlmld";
      powerManagement.resumeCommands = "${pkgs.kmod}/bin/modprobe iwlmld";
    };
  apollo-cpu-c-states = {
    # Use latest kernel
    boot.kernelParams = [
      # disable C10 cpu state (or anything higher than C6) as it results in immense slowdowns
      "intel_idle.max_cstate=6"
    ];
  };
  apollo-stateVersion = {
    system.stateVersion = "25.05";
    home-manager.users.ibrahim.home.stateVersion = "24.05";
  };
in
{
  inherit flake;
}
