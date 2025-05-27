# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{pkgs}: {
  evil-helix = pkgs.callPackage ./evil-helix.nix { };
  # example = pkgs.callPackage ./example { };
}
