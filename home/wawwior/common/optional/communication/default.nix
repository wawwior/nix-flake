{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    signal-desktop
    vesktop
    # insecure.cinny-desktop
  ];
}
