{ config, ... }:
{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 5 --keep-since 3d --nogcroots";
    flake = "${config.hostSpec.home}/.nixos";
  };
}
