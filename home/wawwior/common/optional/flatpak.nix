{ inputs, config, ... }:
{

  imports = [
    inputs.declarative-flatpak.homeModule
  ];

  services.flatpak = {
    enable = true;
    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    };

    packages = [ ];
  };

  xdg.systemDirs.data = [
    "${config.home.homeDirectory}/.local/share/flatpak/exports"
  ];
}
