{ inputs, pkgs, ... }:
{
  imports = [
    ./audio.nix
    inputs.musnix.nixosModules.musnix
  ];

  environment.systemPackages = with pkgs; [
    qpwgraph
  ];

  musnix = {
    enable = true;
    rtcqs.enable = true;
    soundcardPciId = "28:00.3";
  };
}
