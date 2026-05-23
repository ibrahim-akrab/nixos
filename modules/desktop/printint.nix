{
  flake.modules.nixos.desktop = { pkgs, ... }: {
    services.printing = {
      enable = true;
    };
    hardware.printers.ensureDefaultPrinter = "hp1300";
    hardware.printers.ensurePrinters = [
      {
        name = "hp1300";
        location = "USB";
        deviceUri = "usb://HP/LaserJet%201300?serial=00CNCD892816";
        model = "drv:///sample.drv/generic.ppd";
      }
    ];
  };
}
