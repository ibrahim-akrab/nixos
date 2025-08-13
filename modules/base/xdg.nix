{ lib, ... }:
{
  flake.modules.homeManager.base = {
    xdg = {
      enable = lib.mkDefault true;
      mime.enable = lib.mkDefault true;
      userDirs = {
        enable = lib.mkDefault true;
        createDirectories = lib.mkDefault true;
        templates = lib.mkDefault null;
        music = lib.mkDefault null;
        videos = lib.mkDefault null;
        publicShare = lib.mkDefault null;
      };
    };
  };
}
