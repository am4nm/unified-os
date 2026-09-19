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

  # 5. Force systemd-logind to ignore lid switches completely
  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
    extraConfig = ''
      HandleLidSwitch=ignore
      HandleLidSwitchDocked=ignore
      HandleLidSwitchExternalPower=ignore
      LidSwitchIgnoreInhibited=no
    '';
  };

  # 6. Completely disable Systemd Sleep & Suspend Targets
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  # 7. Prevent kernel-level ACPI lid sleep triggers
  boot.kernelParams = [ "button.lid_init_state=open" ];
}
