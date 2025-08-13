{ config, ... }:
{
  flake = {
    meta.users = {
      ibrahim = {
        email = "ibrahim.m.akrab@gmail.com";
        name = "Ibrahim Akrab";
        username = "ibrahim";
        authorizedKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAey37St4eX4Y7Em3tW0L8jFnQvEWilcbHQxeqkB9Yf+ ibrahim@ibrahim-desktop"
        ];
        hashedPassword = "$6$bHLwBWJR3ymg.Yo2$eqX0cXWWpeN2UKzpHZAPBEVFpm1S9EVUw2uX8kyS6uFV./o3SRFgqBP7UKUsLKJ3T7HtLDPwWugM/rlHalel4/"; # mkpasswd -m sha-512
      };
    };

    modules.nixos.ibrahim =
      { ... }:
      {
        users.users.ibrahim = {
          description = config.flake.meta.users.ibrahim.name;
          isNormalUser = true;
          createHome = true;
          extraGroups = [
            "audio"
            "video"
            "input"
            "networkmanager"
            "sound"
            "tty"
            "wheel"
          ];
          openssh.authorizedKeys.keys = config.flake.meta.users.ibrahim.authorizedKeys;
          hashedPassword = config.flake.meta.users.ibrahim.hashedPassword;
        };
      };
  };
}
