{
  flake.modules.nixos.apollo =
    { pkgs, ... }:
    {
      # Fix wifi not working after suspend
      powerManagement.powerDownCommands = "${pkgs.kmod}/bin/modprobe -r iwlmld";
      powerManagement.resumeCommands = "${pkgs.kmod}/bin/modprobe iwlmld";
    };
}
