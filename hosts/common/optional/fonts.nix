{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    corefonts
    nerd-fonts.dejavu-sans-mono
    (google-fonts.override {
      fonts = [
        "Cardo"
        "Didact Gothic"
      ];
    })
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
