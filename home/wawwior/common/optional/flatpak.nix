{ inputs, config, ... }:
{

  imports = [
    inputs.declarative-flatpak.homeManagerModules.declarative-flatpak
  ];

  services.flatpak = {
    enableModule = true;
    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    };

    packages = [ "flathub:app/io.github.limo_app.limo/x86_64/stable" ];
    runOnActivation = true;
  };

  xdg.systemDirs.data = [
    "${config.home.homeDirectory}/.local/share/flatpak/exports"
  ];
}
