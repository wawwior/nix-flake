{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (prismlauncher.override {
      jdk21 = pkgs.temurin-bin-21;
    })
  ];
}
