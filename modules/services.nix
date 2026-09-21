{ config, pkgs, ... }: {
  # 1\. Container Runtime with GPU Passthrough support
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  # 2\. Hardware Acceleration Graphics stack (for Docker &amp; Sunshine streaming)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # 3\. OpenSSH Daemon for Secure Remote Management
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };

  # 4\. Disable Wi-Fi Power Saving (prevents Wi-Fi chip from turning off on lid close)
  networking.networkmanager.wifi.powersave = false;

  # 5\. Force systemd-logind to ignore lid switches completely
  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
    settings = {
      Login = {
        LidSwitchIgnoreInhibited = "no";
      };
    };
  };

  # 6\. Completely disable Systemd Sleep &amp; Suspend Targets
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  # 7\. Prevent kernel-level ACPI lid sleep triggers
  boot.kernelParams = [ "button.lid\_init\_state=open" ];

  # =========================================================================
  # REMOTE GAMING ADDITIONS (SUNSHINE, UINPUT &amp; STEAM)
  # =========================================================================

  # 8\. Enable Kernel Modules &amp; udev Rules for Virtual Gamepads (uinput)
  boot.kernelModules = [ "uinput" ];
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static\_node=uinput"
  '';

  # 9\. Sunshine Streaming Host Daemon
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;  # Required for KMS display capture &amp; real-time scheduling
    openFirewall = true; # Automatically opens streaming ports (TCP/UDP 47984-47990, 48010)
  };

  # 10\. Grant User Permissions for Render Nodes &amp; Virtual Inputs
  users.users.admin.extraGroups = [ "video" "input" "render" ];

  # 11\. Enable Steam &amp; Compatibility Layers (Proton runtime)
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
}
