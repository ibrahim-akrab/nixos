{ inputs, ... }:
{
  flake-file.inputs.mixrank.url = "git+ssh://git@gitlab.com/mixrank/mixrank";

  flake.modules.nixos.mixrank.imports = [ inputs.mixrank.nixosModules.dev-machine ];
}
