{ lib, ... }:
{
  flake.modules = {
    homeManager.base = {
      programs = {
        neovim = {
          enable = lib.mkDefault true;
          viAlias = lib.mkDefault true;
          vimAlias = lib.mkDefault true;
          vimdiffAlias = lib.mkDefault true;
          defaultEditor = lib.mkDefault true;
        };
      };
    };
  };
}
