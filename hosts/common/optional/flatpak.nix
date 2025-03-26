{ ... }:
{
  services.flatpak = {
    enable = true;
  };

  systemd.network.wait-online.enable = false;
}
