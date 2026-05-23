{
  flake.modules.nixos.apollo =
    {
      services.pipewire.wireplumber.extraConfig."51-msi-audio-fix" = {
        "wireplumber.settings" = {
          "device.restore-profile" = false;
          "device.restore-routes" = false;
        };

        "monitor.alsa.rules" = [
          {
            matches = [
              {
                "device.name" = "alsa_card.pci-0000_00_1f.3-platform-skl_hda_dsp_generic";
              }
            ];
            actions = {
              update-props = {
                "api.alsa.use-ucm" = false;
              };
            };
          }
          {
            matches = [
              {
                "node.name" = "~alsa_output\\.pci-0000_00_1f\\.3-platform-skl_hda_dsp_generic\\.HiFi__HDMI.*__sink";
              }
            ];
            actions = {
              update-props = {
                "priority.session" = 1;
              };
            };
          }
        ];
      };
    };
}
