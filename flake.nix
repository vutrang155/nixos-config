{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    {
      nixosConfigurations = {
        old-laptop = nixpkgs.lib.nixosSystem {
          modules = [
            ./configuration.nix
            ./old-laptop
          ];
        };
      };
    };
}
