{ inputs, lib, ... }:
{
  # Declare treefmt-nix flake input
  flake-file.inputs.treefmt-nix.url = "github:numtide/treefmt-nix";

  # Import the treefmt flake-parts module
  imports = [ inputs.treefmt-nix.flakeModule ];

  # Configure treefmt (only if the module is imported)
  perSystem = { pkgs, ... }: {
    treefmt = {
      # Project root marker
      projectRootFile = "flake.nix";

      # Make this the default formatter for `nix fmt`
      flakeFormatter = true;

      # Enable formatting check for `nix flake check`
      flakeCheck = true;

      # Formatter programs
      programs = {
        # Nix files - using nixpkgs-fmt
        nixpkgs-fmt.enable = true;

        # Markdown, YAML, JSON, CSS, JavaScript, TypeScript
        prettier.enable = true;

        # Shell scripts - 2 space indentation
        shfmt = {
          enable = true;
          indent_size = 2;
        };
      };

      # Global exclusion patterns
      settings.global.excludes = [
        # Configuration files that shouldn't be formatted
        ".envrc"
        ".editorconfig"

        # Auto-generated files
        "flake.nix"
        "flake.lock"

        # Shell scripts (historical exclusion)
        "*.sh"

        # Binary and media files
        "*.jpg"
        "*.jpeg"
        "*.png"
        "*.gif"
        "*.qcow2"

        # Build artifacts
        "result"
        "result-*"
      ];
    };
  };
}
