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
  # 1. Enable OpenSSH Daemon for Remote Management
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true; # Can set to false once SSH keys are deployed
      PermitRootLogin = "yes";
    };
  };

  # 2. Prevent Sleep / Suspend When Closing the Laptop Lid
  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
  };

  # ... retain existing Docker and hardware graphics configurations
}

