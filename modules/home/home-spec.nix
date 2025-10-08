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
        description = "is graphical";
      };
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
