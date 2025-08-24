{
  flake.modules.nixos.apollo = {
    boot.kernelParams = [
      # disable C10 cpu state (or anything higher than C6) as it results in immense slowdowns
      "intel_idle.max_cstate=6"
    ];
  };
}
