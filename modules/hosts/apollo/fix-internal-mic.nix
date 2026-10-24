{
  flake.modules.nixos.apollo =
    { pkgs, ... }:
    {
      services.pipewire.extraConfig.pipewire."60-internal-mic" = {
        "context.objects" = [
          {
            factory = "adapter";
            args = {
              "factory.name" = "api.alsa.pcm.source";
              "node.name" = "alsa_input.internal-mic";
              "node.description" = "Internal Microphone";
              "media.class" = "Audio/Source";
              "api.alsa.path" = "hw:sofhdadsp,6";
              "audio.format" = "S32LE";
              "audio.rate" = 48000;
              "audio.channels" = 4;
              "audio.position" = [ "FL" "FR" "RL" "RR" ];
              "priority.session" = 2000;
              "priority.driver" = 2000;
            };
          }
        ];
      };

      systemd.services.unmute-internal-mic = {
        wantedBy = [ "sound.target" ];
        after = [ "sound.target" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.alsa-utils}/bin/amixer -c sofhdadsp cset name='Dmic0 Capture Switch' on,on,on,on";
        };
      };
    };
}
