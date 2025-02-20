{ inputs, pkgs, config, ... }: {

  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;

    targets.grub.enable = false;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    image = ./wallpaper.png;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    # TODO: kitty font
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.dejavu-sans-mono;
        name = "DejaVuSansM Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = config.stylix.fonts.sansSerif;
    };
  };

}
