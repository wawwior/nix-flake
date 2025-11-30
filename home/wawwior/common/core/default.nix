{
  lib,
  config,
  ...
}:
{

  imports = lib.flatten [

    ./zsh
    ./git.nix
    ./helix.nix
    ./kitty.nix
    ./tools
    ./ssh.nix
    ./direnv.nix

    (map lib.custom.fromTop [
      "modules/common/host-spec.nix"
    ])
  ];

  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${config.home.homeDirectory}/.desktop";
    music = "${config.home.homeDirectory}/media/audio";
    videos = "${config.home.homeDirectory}/media/video";
    pictures = "${config.home.homeDirectory}/media/images";
    download = "${config.home.homeDirectory}/downloads";
    documents = "${config.home.homeDirectory}/documents";
    extraConfig = {
      XDG_PUBLICSHARE_DIR = "/var/empty";
      XDG_TEMPLATES_DIR = "/var/empty";
    };
  };
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.configFile."mimeapps.list".force = true;
}
