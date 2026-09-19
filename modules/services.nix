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