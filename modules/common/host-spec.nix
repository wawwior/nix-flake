{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.hostSpec = {
    hostName = lib.mkOption {
      type = lib.types.str;
      description = "The hostname of the host";
    };
    display = {
      name = lib.mkOption {
        type = lib.types.str;
        example = "DP-1";
      };
      mode = lib.mkOption {
        type = lib.types.str;
        default = "1920x1080@60";
      };
      scale = lib.mkOption {
        type = lib.types.float;
        default = 1.0;
      };
    };
  };
}
