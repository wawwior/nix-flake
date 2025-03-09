{ pkgs, ... }:
{
  home.packages = with pkgs; [
    corefonts
    nerd-fonts.jetbrains-mono
  ];
}
