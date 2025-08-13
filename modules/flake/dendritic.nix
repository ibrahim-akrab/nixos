{
  inputs,
  ...
}:
{
  imports = [
    inputs.flake-file.flakeModules.dendritic
  ];
  # disable lock file flattenning until allfollow stack overflow errors are fixed when using mixrank flake
  flake-file.prune-lock.enable = false;
}
