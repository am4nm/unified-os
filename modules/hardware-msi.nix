{ config, lib, pkgs, modulesPath, ... }: { 
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ]; 
  # Bootloader & Kernel Modules extracted from physical probe 
  boot.initrd.availableKernelModules = [ 
    "nvme" 
    "xhci\_pci" 
    "usb\_storage" 
    "sd\_mod" 
    "rtsx\_pci\_sdmmc" 
  ]; 
  boot.initrd.kernelModules = [ ]; 
  boot.kernelModules = [ "kvm-amd" ]; 
  boot.extraModulePackages = [ ];

  # CPU Microcode & Non-Free Hardware Firmware 
  nixpkgs.hostPlatform = lib.mkDefault "x86\_64-linux"; 
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware; 
  hardware.enableRedistributableFirmware = true; 

  # GPU Acceleration (/dev/dri/renderD128) for Immich & AI 
  hardware.graphics = { 
    enable = true; 
    enable32Bit = true; 
  }; 
}