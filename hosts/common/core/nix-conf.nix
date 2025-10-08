{ inputs, config, ... }:
{

  nix = {
    settings = {
      trusted-users = [
        "@wheel"
        "nixremote"
      ];
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    extraOptions = ''
      !include ${config.sops.templates."nix-access-tokens.conf".path}
      builders-use-substitutes = true
    '';

    buildMachines = [
      {
        hostName = "192.168.178.35";
        system = "x86_64-linux";
        protocol = "ssh-ng";
        maxJobs = 16;
        speedFactor = 5;
        supportedFeatures = [
          "kvm"
          "benchmark"
          "big-parallel"
          "nixos-test"
        ];
        mandatoryFeatures = [ ];

      }
    ];

    distributedBuilds = false;

    optimise.automatic = true;

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  };
}
