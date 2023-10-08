# nixos-generate-config --show-hardware-config > ./system/hardware-configuration.nix
# sudo nixos-rebuild switch --flake ".#vm-intel"
{
  description = "NixOS config.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    user = "nu11z";
    mkSystem = import ./lib/mksystem.nix {
      inherit nixpkgs inputs;
    };
  in {
    nixosConfigurations.vbox-intel = mkSystem "vbox-intel" {
      system = "x86_64-linux";
      inherit user;
    };
    nixosConfigurations.pc-intel = mkSystem "pc-intel" {
      system = "x86_64-linux";
      inherit user;
    };
  };
}
