{
  config,
  lib,
  ...
}:
{
  options.userSpec = {
    users = lib.mkOption {
      type =
        with lib.types;
        attrsOf (submodule {
          options = {
            isWheel = lib.mkOption {
              type = lib.types.bool;
              description = "is this user @wheel";
              default = false;
            };
            extraGroups = lib.mkOption {
              type = with lib.types; listOf str;
              description = "groups the user is added too";
              default = [ ];
            };
            optionalGroups = lib.mkOption {
              type = with lib.types; listOf str;
              description = "groups added if they exist";
              default = [ ];
            };
            graphical = lib.mkOption {
              type = lib.types.bool;
              description = "configures stylix";
              default = false;
            };
          };
        });
    };
  };

  config.assertions = [
    {
      assertion = !(config.userSpec.users ? "root");
      message = "cannot define root user";
    }
  ];
}
