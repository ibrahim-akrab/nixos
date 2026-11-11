# Hermes

`default.nix` selects the shared `base`, `audio`, `bluetooth`, `desktop`, `dev`,
`phosh`, and user modules alongside `alioth` and `hermes`. `alioth` is the hardware codename;
`hermes` is the hostname. Device files live in the separate
`ibrahim-akrab/alioth-device` GitHub repository.

From the repository root:

```sh
nix flake update mobile-nixos
nix flake update alioth-device
nix build .#nixosConfigurations.hermes.config.mobile.outputs.android.android-fastboot-images
```

Review the lock-file diff before using a new image. Phosh uses the shared
`ibrahim` account. Its WiFi settings are saved by NetworkManager on the phone;
a fresh installation needs a connection configured through Phosh or `nmcli`.
