{
  description = "My NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    { nixpkgs, nixpkgs-unstable, home-manager, neovim-nightly-overlay, ... }:
    let
      system = "x86_64-linux";
      overlay-nixpkgs = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ({ config, pkgs, ... }: {
              nixpkgs.overlays =
                [ overlay-nixpkgs neovim-nightly-overlay.overlay ];
            })
            ./nixos/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.kylec = import ./home-manager/home.nix;
              };
            }
          ];
        };
      };
    };
}
