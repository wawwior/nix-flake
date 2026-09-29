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
        projects = "${config.home.homeDirectory}/projects";
        templates = null;
        publicShare = null;
      };
      xdg.mime.enable = true;
      xdg.mimeApps.enable = true;
      xdg.configFile."mimeapps.list".force = true;
    };
  };
}
