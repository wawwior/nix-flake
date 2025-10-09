{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    termusic
    yt-dlp
  ];
  programs.spotify-player = {
    enable = true;
    settings = {
      client_id_command = {
        command = "cat";
        args = [ config.homeSpec.spotifyClientIdPath ];
      };
      default_device = "apollo";
      device = {
        name = "apollo";
        device_type = "computer";
        volume = 70;
        bitrate = 320;
        autoplay = true;
      };
    };
  };
}
