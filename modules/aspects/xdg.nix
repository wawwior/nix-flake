{
  flake.aspects.xdg = {
    home = { config, ... }: {
      xdg.enable = true;
      xdg.userDirs = {
        enable = true;
        createDirectories = true;
        setSessionVariables = true;
        desktop = "${config.home.homeDirectory}/.desktop";
        music = "${config.home.homeDirectory}/media/audio";
        videos = "${config.home.homeDirectory}/media/video";
        pictures = "${config.home.homeDirectory}/media/images";
        download = "${config.home.homeDirectory}/downloads";
        documents = "${config.home.homeDirectory}/documents";
        extraConfig = {
          PUBLICSHARE = "/var/empty";
          TEMPLATES = "/var/empty";
        };
      };
      xdg.mime.enable = true;
      xdg.mimeApps.enable = true;
      xdg.configFile."mimeapps.list".force = true;
    };
  };
}
