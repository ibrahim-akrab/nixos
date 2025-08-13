toplevel: {
  flake.modules.nixos.root =
    { ... }:
    {
      users.users.root = {
        openssh.authorizedKeys.keys = toplevel.config.flake.meta.users.ibrahim.authorizedKeys;
        hashedPassword = toplevel.config.flake.meta.users.ibrahim.hashedPassword;
      };
    };
}
