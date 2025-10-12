{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    signal-desktop
    vesktop
    stable.insecure.cinny-desktop
  ];
}
