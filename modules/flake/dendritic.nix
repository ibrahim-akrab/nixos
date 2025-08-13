{
  inputs,
  ...
}:
{
  imports = [
    inputs.flake-file.flakeModules.dendritic
  ];
  # disable lock file flattenning until allfollow is fixed
  # flake-file.prune-lock.enable = false;
}
