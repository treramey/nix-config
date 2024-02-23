{ self, inputs, specialArgs}:let
  inherit (inputs.nixpkgs) lib;
  args = {
    hostname = "macos-nix";
    system = "x86_64-darwin";
    darwin-modules = [
      ../modules/darwin
    ];
    home-modules.imports = [
      ../home/darwin
    ];
    inherit inputs specialArgs;
  };
in 
  lib.attrsets.mergeAttrsList [
    (import ./macos.nix args)
  ]

