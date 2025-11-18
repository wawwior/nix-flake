{ lib, ... }:
{

  options.display = {
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
}
