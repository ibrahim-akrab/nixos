
# What is this

My nixos configuration used for setting up my laptop & desktop

# What's included in the setup:

* nixos configuration using nix flakes to ensure reproducability
* using [disko](https://github.com/nix-community/disko "disko") for declarative disk partitioning and formatting using nix 
* full disk encryption on top of btrfs (with encrypted swap)
* opt-in [impermenance](https://github.com/nix-community/impermanence "impermenance") following Graham's amazing blog post: [Erase your darlings ](https://grahamc.com/blog/erase-your-darlings/ "Erase your darlings ") (backed by btrfs instead of zfs)

# To-Do's:
- [ ] secure-boot using [lanzaboote](https://github.com/nix-community/lanzaboote "lanzaboote")
- [ ] back disk encryption by TPM
- [ ] setup home-manager to work with impermenance (as nix module) and standalone for on-the-fly user setup


- [ ] laptop setup:
    - [x] fingerprint reader
    - [x] light sensor
	- [x] automatically adjust screen brightness according to the light sensor using [wluma](https://github.com/maximbaz/wluma "wluma")
	- [x] custom battery charging threshold in linux (inspired by MSI dragon center)
	- [ ] fix audio muted on boot
	- [ ] fix wi-fi not working after suspend
	
	
- [ ] desktop setup:
	- [ ] TBD
 
