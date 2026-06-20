{
  description = "Chovy's NixOS";


  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, sops-nix, ... }@inputs:
    let
      system = "x86_64-linux";  # use "aarch64-linux" for ARM laptops

      # Evaluate the unstable package set so modules can use it.
      # We do this here once so every module gets the same instance.
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      # "laptop" here must exactly match the hostname of your machine.
      # This is what --flake ~/nixos-config#laptop refers to.
      nixosConfigurations.asus = nixpkgs.lib.nixosSystem {
        inherit system;

        # specialArgs makes extra variables available as function arguments
        # in every module. This is how pkgs-unstable and inputs reach your
        # module files even though they are not standard NixOS arguments.
        specialArgs = { inherit inputs pkgs-unstable; };

        # modules is the list of everything that makes up your system config.
        # NixOS merges all of these together into one final configuration.
        modules = [
          ./hosts/asus          # your machine-specific config (loads default.nix)
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs   = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs pkgs-unstable; };
            
            # "import" here evaluates the file and hands the resulting function
            # to home-manager, which then calls it with the right arguments.
            home-manager.users.chovy = {
              imports = [
                inputs.sops-nix.homeManagerModules.sops
                ./home/chovy/default.nix
              ];
            };
          }
        ];
      };
    };
}
