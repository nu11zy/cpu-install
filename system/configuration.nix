{ inputs, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Hostname
  networking.hostName = "cpu"; 

  # Enable networking
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = false;
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbVariant = "";
    desktopManager.xfce.enable = true;
  };

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  services.gnome.gnome-keyring.enable = true;

  security.pam.services.gdm.enableGnomeKeyring = true;
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Features and packages
  # Qemu
  virtualisation.libvirtd.enable = true;
  # Zsh
  programs.zsh.enable = true;

  programs = {
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    # VM manager
    virt-manager
    # VPN
    wireguard-tools
    # Git
    git
    # Xfce tools
    pavucontrol
    xfce.catfish
    gnome.file-roller
    gnome.gnome-disk-utility
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-xkb-plugin
    xfce.xfce4-appfinder
    xfce.xfce4-panel
    # Archive tools
    unzip
    p7zip
    # Cat with colors 
    bat
    # CLI Hex viewer
    hexyl
    # fzf
    fzf
    # GTK
    papirus-icon-theme
    nordic
    # Clipboard tool
    xclip
    # Font manager
    font-manager
  ];

  # Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    dina-font
  ];

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  system.stateVersion = "23.05";
}
