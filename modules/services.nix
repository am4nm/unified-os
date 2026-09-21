{ config, pkgs, ... }:

{
  # 1. Container Runtime with GPU Passthrough support
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
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
  boot.kernelModules = [ "uinput" ];

  # 11. Sunshine Streaming Host Daemon
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  # 12. Grant User Permissions for Render Nodes & Virtual Inputs
  users.users.admin.extraGroups = [ "video" "input" "render" ];

  # 13. Enable Steam & Compatibility Layers (Proton runtime)
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
}
