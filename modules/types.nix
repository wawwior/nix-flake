{ lib, ... }: {
  flake.lib.types =
    let

      inherit (builtins)
        head
        foldl'
        concatMap
        isAttrs
        ;

      inherit (lib)
        isStringLike
        mergeOneOption
        mergeEqualOption
        showOption
        showFiles
        getFiles
        ;

      inherit (lib.types)
        attrsOf
        ;

      anythingConcatLists = lib.types.anything // {
        merge =
          loc: defs:
          let

            getType =
              value: if isAttrs value && isStringLike value then "stringCoercibleSet" else builtins.typeOf value;

            commonType = foldl' (
              type: def:
              if getType def.value == type then
                type
              else
                throw "The option `${showOption loc}' has conflicting option types in ${showFiles (getFiles defs)}"
            ) (getType (head defs).value) defs;

            mergeFunction =

              {
                set = (attrsOf anythingConcatLists).merge;
                list = loc: defs: concatMap (def: def.value) defs;
                stringCoercibleSet = mergeOneOption;
                lambda =
                  loc: defs: arg:
                  anythingConcatLists.merge (loc ++ [ "<function body>" ]) (
                    map (def: {
                      file = def.file;
                      value = def.value arg;
                    }) defs
                  );
              }
              .${commonType} or mergeEqualOption;
          in
          mergeFunction loc defs;
      };
    in
    {
      inherit anythingConcatLists;
    };
}
