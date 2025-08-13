{ lib, ... }:
{
  flake.modules.nixos.base = {
    # https://mastodon.online/@nomeata/109915786344697931
    documentation = {
      enable = lib.mkDefault false;
      doc.enable = lib.mkDefault false;
      info.enable = lib.mkDefault false;
    };
  };
}
