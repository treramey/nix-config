args:
with args;let
  inherit (specialArgs) username;
  inherit (inputs) nix-darwin home-manager;
in {
  darwinConfigurations = {
    "${hostname}" = nix-darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = 
      darwin-modules
      ++ [
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.extraSpecialArgs = specialArgs;

          home-manager.users.${username} = home-modules;
        }
      ];
    };
  };
}
