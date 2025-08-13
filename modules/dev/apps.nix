{
  flake.modules.homeManager.dev =
    {
      inputs,
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        # pkgs.gparted
        pkgs.wl-clipboard
        # pkgs.copilot-language-server
        # pkgs.aider-chat
        # pkgs.qutebrowser
        # pkgs.multimarkdown

        yazi # file tui
        # pkgs.zoxide # cd
        # pkgs.nix-search-cli
        # pkgs.nixd # lsp
        # pkgs.nixfmt-rfc-style
        # pkgs.ispell
        # pkgs.gh

        inputs.self.packages.${pkgs.system}.fs-diff-btrfs
        inputs.self.packages.${pkgs.system}.persist
        slack
        telegram-desktop

        tree
        cht-sh
        vim
        wget
        git
        lazygit
        #   pkgs.fzf
        #   pkgs.ripgrep # grep
        #   pkgs.bat # cat
        #   pkgs.bottom
        #   pkgs.htop
        #   pkgs.eza # ls
        #   pkgs.fd # find
        #   pkgs.lazygit # no magit
        #   pkgs.tig # alucard
        #   pkgs.cachix
        #   pkgs.jq
        #   pkgs.home-manager
        inputs.self.packages.${pkgs.system}.set-charge-limit
      ];
    };
}
