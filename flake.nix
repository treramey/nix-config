{
  description = "Nix for macOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-23.11-darwin";

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs dependencies.
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    ...
  }: let
    username = "myles";
    fullname = "Myles Mo";
    usermail = "mylesmo.ash@gmail.com";
    specialArgs = inputs // {inherit username usermail fullname;};

    systems = ["x86_64-darwin"];
    forEachSystem = f: (nixpkgs.lib.genAttrs systems f);
    allSystemConfigurations = import ./systems {inherit self inputs specialArgs;};
  in 
    allSystemConfigurations
    // {
      homeManagerModules = import ./modules/home;
      formatter = forEachSystem (
        system: nixpkgs.legacyPackages.${system}.alejandra
      );
  };

  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
    ];
  };
}
