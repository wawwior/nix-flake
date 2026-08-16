{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{

  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {

    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    polarity = "dark";

    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/os/nix-black-4k.png";
      sha256 = "sha256-HRZYeKDmfA53kb3fZxuNWvR8cE96tLrqPZhX4+z4lZA=";
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

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
      sizes = {
        applications = 12;
        desktop = 10;
        popups = 10;
        terminal = 12;
      };
    };
  };

  home-manager.users =
    with builtins;
    (mapAttrs (
      name: value:
      lib.mkIf value.graphical {
        stylix = {
          icons = {
            enable = true;
            package = pkgs.adwaita-icon-theme;
            dark = "Adwaita";
            light = "Adwaita";
          };

          targets = {
            # gnome = {
            #   fonts.override =
            #     let
            #       sans = {
            #         package = pkgs.dejavu_fonts;
            #         name = "DejaVu Sans";
            #       };
            #     in
            #     {
            #       sansSerif = sans;
            #       serif = sans;
            #     };
            # };
            gtk = {
              flatpakSupport.enable = false;
              # fonts.override =
              #   let
              #     sans = {
              #       package = pkgs.dejavu_fonts;
              #       name = "DejaVu Sans";
              #     };
              #   in
              #   {
              #     sansSerif = sans;
              #     serif = sans;
              #   };
            };
            vesktop.enable = false;
            zen-browser.profileNames = [ "${name}" ];
          };
        };

        programs.oh-my-posh.useTheme = "catppuccin_mocha";
      }
    ) config.userSpec.users);
}
