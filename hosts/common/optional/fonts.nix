{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    twemoji-color-font
    corefonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.dejavu-sans-mono
  ];

  fonts.fontDir.enable = true;

  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "Noto Sans" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "DejaVuSansM Nerd Font Mono" ];
      emoji = [ "Twitter Color Emoji" ];
    };
  };
}
