{ config, pkgs, ... }: 

{ 
  # Bootloader Configuration (UEFI Systemd-Boot) 
  boot.loader.systemd-boot.enable = true; 
  boot.loader.efi.canTouchEfiVariables = true; 
  
  # Hostname & Networking 
  networking.hostName = "unified-pro"; 
  networking.networkmanager.enable = true; 

  # System Locale & Time 
  time.timeZone = "UTC"; 
  i18n.defaultLocale = "en_US.UTF-8"; 

  # Enable Flakes & Modern Nix CLI 
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  # Enable Unfree Packages (Required for GPU Acceleration & Drivers) 
  nixpkgs.config.allowUnfree = true; 

  # Admin User Configuration 
  users.users.admin = { 
    isNormalUser = true; 
    extraGroups = [ "wheel" "docker" ]; 
  }; 

  # Base Core Utilities 
  environment.systemPackages = with pkgs; [ 
    git curl vim htop pciutils lshw 
  ]; 

  # =========================================================================
  # VIRTUAL MEMORY (Swap File to prevent OOM gaming crashes)
  # =========================================================================
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 16384; 
  } ];

  system.stateVersion = "24.05"; 
}