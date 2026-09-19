{ config, pkgs, ... }: 

{ 
  # Bootloader Configuration (UEFI Systemd-Boot) 
  boot.loader.systemd-boot.enable = true; 
  boot.loader.efi.canTouchEfiVariables = true; 
  
  # Hostname &amp; Networking 
  networking.hostName = "unified-pro"; 
  networking.networkmanager.enable = true; 

  # System Locale &amp; Time 
  time.timeZone = "UTC"; 
  i18n.defaultLocale = "en\_US.UTF-8"; 

  # Enable Flakes &amp; Modern Nix CLI 
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  # Enable Unfree Packages (Required for GPU Acceleration &amp; Drivers) 
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

  system.stateVersion = "24.05"; 
}