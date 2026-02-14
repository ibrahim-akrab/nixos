{
  flake.modules.homeManager.dev =
    {
      pkgs,
      osConfig,
      ...
    }:
    {
      programs.vscode = {
        enable = !(osConfig.wsl.enable or false); # disable it if inside wsl (since it falls back to windows native version)
        profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            dracula-theme.theme-dracula
            vscodevim.vim
            yzhang.markdown-all-in-one
            ms-python.python
            ms-pyright.pyright
            bbenoist.nix
          ];
          userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
          keybindings = builtins.fromJSON (builtins.readFile ./keybindings.json);
        };
      };
    };
}
