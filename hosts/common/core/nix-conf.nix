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

    distributedBuilds = false;

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  };
}
