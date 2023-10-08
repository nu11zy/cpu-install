{ inputs, ... }:

{ config, pkgs, ... }:

{
  # Home-manager version
  home.stateVersion = "22.11";

  # Home
  home.username = "nu11z";
  home.homeDirectory = "/home/nu11z";

  # Software and configs
  # Browser
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
  };
  
  # Code\Text editor
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      pkief.material-icon-theme
      jnoortheen.nix-ide
    ];
  };

  # Git
  programs.git = {
    enable = true;
    userName  = "nu11zy";
    userEmail = "55335158+nu11zy@users.noreply.github.com";
  };

  home.packages = [
    # Terminal
    pkgs.alacritty
    # Note taking app
    pkgs.obsidian
    # Messenger
    pkgs.telegram-desktop
    # Screenshot tool
    pkgs.ksnip
    # Password manager
    pkgs.bitwarden
    # Mail client
    pkgs.thunderbird
  ];

  # Dotfiles
  xdg.configFile = {
    "alacritty/alacritty.yml".source = dotfiles/alacritty.yml;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
