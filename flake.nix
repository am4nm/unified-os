{
 description = "Unified OS - Sovereign Consumer Appliance Master Blueprint";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations = {
      # Pro Tier Target (MSI Laptop Prototype)
      pro-tier = nixpkgs.lib.nixosSystem {
        system = "x86\_64-linux";
        modules = [
          ./modules/hardware-msi.nix
          ./modules/system.nix
          ./modules/services.nix
        ];
      };
    };
  };
}