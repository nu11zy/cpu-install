{ inputs, ... }:

{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nu11z";
  home.homeDirectory = "/home/nu11z";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

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
    ];
  };
  
  # The home.packages option allows you to install Nix packages into your
  # environment.
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

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Dotfiles
  xdg.configFile = {
    "alacritty/alacritty.yml".source = dotfiles/alacritty.yml;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
