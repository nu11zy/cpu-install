{ nixpkgs, inputs }:

name:
{
  system,
  user
}:

let
  systemConfig = ../system/${name}.nix;
  userConfig = ../users/${user}/user.nix;
  homeConfig = ../users/${user}/home.nix;
  
  systemFunc = nixpkgs.lib.nixosSystem;
  home-manager = inputs.home-manager.nixosModules;
in systemFunc rec {
  inherit system;
  
  modules = [
    systemConfig
    userConfig
    home-manager.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = import homeConfig {
        inputs = inputs;
      };
    }
  ];
}
