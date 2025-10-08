{ inputs, pkgs, ... }:
{

  imports = [ inputs.vintagestory-nix.homeModules.default ];

  programs.vs-launcher = {
    enable = true;
    settings.gameVersions = with pkgs.vintagestoryPackages; [
      v1-21-1
      latest
    ];
  };

  home.packages = [
    pkgs.vintagestoryPackages.latest
  ];
}
