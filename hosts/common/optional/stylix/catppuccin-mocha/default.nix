{
  inputs,
  pkgs,
  config,
  ...
}:
let
  hostSpec = config.hostSpec;

  mkTintedPkg =
    base:
    pkgs.stdenv.mkDerivation {
      name = "tinted-schemes-${base}";
      src = pkgs.fetchFromGitHub {
        owner = "tinted-theming";
        repo = "schemes";
        rev = "a1bc2bd89e693e7e3f5764cfe8114e2ae150e184";
        sha256 = "sha256-Hdk850xgAd3DL8KX0AbyU7tC834d3Lej1jOo3duWiOA=";
      };

      installPhase = ''
        mkdir -p $out/share/themes
        cp -r ${base}/* $out/share/themes/
      '';
    };

  tinted-schemes = {
    base16 = mkTintedPkg "base16";
    base24 = mkTintedPkg "base24";
  };
in
{

  imports = [ inputs.stylix.nixosModules.stylix ];

  fonts.packages = with pkgs; [
    nerd-fonts.dejavu-sans-mono
  ];

  stylix = {

    enable = true;

    base16Scheme = "${tinted-schemes.base24}/share/themes/catppuccin-mocha.yaml";

    polarity = "dark";

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
      emoji = {
        package = pkgs.twemoji-color-font;
        name = "Twitter Color Emoji";
      };
    };
  };
  home-manager.users."${hostSpec.username}".stylix = {

    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/os/nix-black-4k.png";
      sha256 = "sha256-HRZYeKDmfA53kb3fZxuNWvR8cE96tLrqPZhX4+z4lZA=";
    };

    iconTheme = {
      enable = true;
      package = pkgs.adwaita-icon-theme;
      dark = "Adwaita";
      light = "Adwaita";
    };
  };
}
