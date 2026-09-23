{ config, pkgs, ... }:

{
  # 1. Container Runtime & Photo Backup (Docker for Immich)
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  # 2. Hardware Acceleration Graphics stack (for Docker & Sunshine streaming)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # 3. OpenSSH Daemon for Secure Remote Management
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };

  # 4. Disable Wi-Fi Power Saving (prevents Wi-Fi chip from turning off on lid close)
  networking.networkmanager.wifi.powersave = false;

  # 5. Force systemd-logind to ignore lid switches completely (Updated Syntax)
  services.logind = {
    settings = {
      Login = {
        HandleLidSwitch = "ignore";
        HandleLidSwitchDocked = "ignore";
        HandleLidSwitchExternalPower = "ignore";
        LidSwitchIgnoreInhibited = "no";
      };
    };
  };

  # 6. Completely disable Systemd Sleep & Suspend Targets
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  # 7. Prevent kernel-level ACPI lid sleep triggers
  boot.kernelParams = [ "button.lid_init_state=open" ];

  # =========================================================================
  # GRAPHICAL DISPLAY (Required for Sunshine Capture)
  # =========================================================================

  # 8. Enable KDE Plasma 6 Desktop Environment
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # 9. Auto-login 'admin' to initialize the display server on boot
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "admin";
  security.pam.services.login.enableKwallet = true;

  # =========================================================================
  # REMOTE GAMING ADDITIONS (SUNSHINE, UINPUT & STEAM)
  # =========================================================================

  # 10. Enable Kernel Modules for Virtual Gamepads (uinput)
  boot.kernelModules = [ "uinput" "kvm-amd" ];

  # 11. Sunshine Streaming Host Daemon
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  # 12. Enable Steam & Compatibility Layers (Proton runtime)
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  # =========================================================================
  # ZERO-TRUST MESH NETWORK ("PRIVATE LANE" WIREGUARD)
  # =========================================================================

  # 13. Kernel-level WireGuard mesh network 
  services.tailscale = {
    enable = true;
    openFirewall = true;
  };

  networking.firewall = {
    allowedUDPPorts = [ 51820 ]; # Native WireGuard UDP Port
  };

  # =========================================================================
  # USER PERMISSIONS & SYSTEM PACKAGES
  # =========================================================================

  # 14. Grant User Permissions for Render Nodes, Virtual Inputs & Docker
  users.users.admin.extraGroups = [ "wheel" "docker" "video" "input" "render" "networkmanager" ];

  # 15. Additional Gaming Launchers, Web browser & Container Utilities
  environment.systemPackages = with pkgs; [
    # Container & Storage Utilities
    docker-compose
    wget
    curl
    git
    htop
    pciutils

    # Gaming & Compatibility Launchers
    heroic
    lutris
    firefox
  ];
}