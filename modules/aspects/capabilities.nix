{ self, lib, ... }: {
  flake.aspects.capabilities = {
    nixos = { config, ... }: {
      options.capabilities = lib.mkOption {
        type = lib.types.attrsOf self.lib.types.anythingConcatLists;
        default = { };
        description = "capabilities to be defined and consumed by aspects";
      };
      config = {
        _module.args.capabilities = config.capabilities;
      };
    };
    home = { config, ... }: {
      options.capabilities = lib.mkOption {
        type = lib.types.attrsOf self.lib.types.anythingConcatLists;
        default = { };
        description = "capabilities to be defined and consumed by aspects";
      };
      config = {
        _module.args.capabilities = config.capabilities;
      };
    };
  };
}
