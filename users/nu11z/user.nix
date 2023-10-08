{ pkgs, ... }:

let
  user = "nu11z";
in {
  users.users.${user} = {
    isNormalUser = true;
    description = "nu11z";
    home = "/home/${user}";
    extraGroups = [ "networkmanager" "wheel" "vboxsf" "libvirtd" ];
    shell = pkgs.zsh;
  };
}
