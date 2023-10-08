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
    package = pkgs.wrapFirefox pkgs.firefox-esr-115-unwrapped {
      extraPolicies = {
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = false;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        PasswordManagerEnabled = false;
        FirefoxHome = {
            Search = true;
            Pocket = false;
            Snippets = false;
            TopSites = false;
            Highlights = false;
        };
        UserMessaging = {
            ExtensionRecommendations = false;
            SkipOnboarding = true;
        };
      };
    };
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

  # Zsh
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    initExtra = builtins.readFile dotfiles/.zshrc;
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "c3d4e576c9c86eac62884bd47c01f6faed043fc5";
          sha256 = "B+Kz3B7d97CM/3ztpQyVkE6EfMipVF8Y4HJNfSRXHtU=";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "143b25eb98aa3227af63bd7f04413e1b3e7888ec";
          sha256 = "TKGCck51qQ50dQGntKaeSk8waK3BlwUjueg4MImTH8k=";
        };
      }
    ];
  };

  gtk = {
    enable = true;
    theme.package = pkgs.nordic;
    theme.name = "Nordic-darker-standart-buttons";
    iconTheme.package = pkgs.papirus-icon-theme;
    iconTheme.name = "ePapirus-Dark";
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
    # Hex editor
    pkgs.imhex
    # Torrent client
    pkgs.qbittorrent
    # Office
    pkgs.libreoffice-qt
    pkgs.hunspell
    pkgs.hunspellDicts.en_US
    pkgs.hunspellDicts.ru_RU
    # Archive manager
    # pkgs.xarchiver
  ];

  # Dotfiles
  xdg.configFile = {
    "alacritty/alacritty.yml".source = ./dotfiles/alacritty.yml;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
