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
          withPython3 = lib.mkDefault false;
          withRuby = lib.mkDefault false;
          coc = {
            enable = true;
          };
        };
      };
    };
  };
}
