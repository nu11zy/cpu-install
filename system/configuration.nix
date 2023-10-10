{ inputs, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-8e747a78-08e0-4864-88c9-fefbc258ea98".device = "/dev/disk/by-uuid/8e747a78-08e0-4864-88c9-fefbc258ea98";
  boot.supportedFilesystems = [ "ntfs" ];

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

  # X11
  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbVariant = "";
    displayManager.lightdm.enable = true;
    desktopManager.cinnamon.enable = true;
  };

  # Enable CUPS to print documents
  services.printing = {
    enable = true;
    drivers = with pkgs; [ hplip ];
  };

  programs.system-config-printer.enable = true;

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Features and packages
  # Qemu
  virtualisation.libvirtd.enable = true;
  # Zsh
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    # VM manager
    virt-manager
    virtiofsd
    # VPN
    wireguard-tools
    # Git
    git
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

  system.stateVersion = "23.05";
}
