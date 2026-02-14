{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    signal-desktop
    # insecure.cinny-desktop
  ];
  programs.vesktop = {
    enable = true;
    vencord.settings.themeLinks = [
      "https://raw.githubusercontent.com/refact0r/midnight-discord/refs/heads/master/themes/flavors/midnight-catppuccin-mocha.theme.css"
    ];
  };
}
