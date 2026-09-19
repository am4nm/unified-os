{ config, pkgs, ... }: 

{ 
  # Container Runtime with GPU Passthrough support 
  virtualisation.docker = { 
    enable = true; 
    autoPrune.enable = true; 
  }; 
  
  # OpenSSH Daemon for Secure Remote Management 
  services.openssh = { 
    enable = true; 
    settings = { 
      PasswordAuthentication = true; 
      PermitRootLogin = "yes"; 
    }; 
  }; 
  
  # Ensure Hardware Acceleration Graphics stack is enabled for Docker 
  hardware.graphics = { 
    enable = true; 
    enable32Bit = true; 
  }; 
}


{
  # Disable Wi-Fi Power Saving (prevents Wi-Fi chip from turning off on lid close)
  networking.networkmanager.wifi.powersave = false;

  # Enable OpenSSH Daemon for Remote Management
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true; # Can set to false once SSH keys are deployed
      PermitRootLogin = "yes";
    };
  };

  # Force systemd-logind to ignore lid switches completely
  services.logind = { lidSwitch = "ignore"; 
  lidSwitchDocked = "ignore"; 
  lidSwitchExternalPower = "ignore"; 
  extraConfig = '' HandleLidSwitch=ignore HandleLidSwitchDocked=ignore HandleLidSwitchExternalPower=ignore LidSwitchIgnoreInhibited=no ''; 
}; 

  # ... retain existing Docker and hardware graphics configurations
}

