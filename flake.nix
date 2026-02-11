{
  description = "Jason's Home Manager Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, }: {
    homeConfigurations = {
      aarch64-darwin = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
        modules = [ ./machines/darwin.nix { home.stateVersion = "24.05"; } ];
      };

      x86_64-linux = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [ ./machines/linux.nix { home.stateVersion = "24.05"; } ];
      };
    };
  };
}
