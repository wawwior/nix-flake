{ inputs, pkgs, ... }:
{
  services.static-web-server = {
    enable = true;
    listen = "[::]:80";
    root = "/srv/http/";
  };
  networking.firewall.allowedTCPPorts = [ 80 ];
}
