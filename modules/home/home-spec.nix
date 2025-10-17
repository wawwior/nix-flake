{
  lib,
  ...
}:
# This is a mix of user spec and host spec that is required by and carries over to home manager
{
  options.homeSpec = {
    hostName = lib.mkOption {
      type = lib.types.str;
    };
    user = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "username";
      };
      home = lib.mkOption {
        type = lib.types.str;
        description = "home dir";
      };
      graphical = lib.mkOption {
        type = lib.types.bool;
        description = "configure stylix";
      };
    };
    display = {
      name = lib.mkOption {
        type = lib.types.str;
        example = "DP-1";
      };
      mode = {
        width = lib.mkOption {
          type = lib.types.int;
          default = 1920;
        };
        height = lib.mkOption {
          type = lib.types.int;
          default = 1080;
        };
        refresh = lib.mkOption {
          type = lib.types.float;
          default = 60;
        };
      };
      scale = lib.mkOption {
        type = lib.types.float;
        default = 1.0;
      };
    };
    spotifyClientIdPath = lib.mkOption {
      type = lib.types.path;
      description = "Spotify client_id path provided by sops-nix";
    };
  };
}
