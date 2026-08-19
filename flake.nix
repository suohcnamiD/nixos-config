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
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations.asus = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs pkgs-unstable; };
        modules = [
          ./hosts/asus
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs   = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs pkgs-unstable; };
            home-manager.users.chovy = {
              imports = [
                inputs.sops-nix.homeManagerModules.sops
                ./home/chovy/default.nix
              ];
            };
          }
        ];
      };

      devShells.${system} = {
        rust = pkgs.mkShell {
          buildInputs = with pkgs; [ rustup pkg-config openssl ];
          PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
          OPENSSL_DIR     = "${pkgs.openssl.dev}";
          OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
          shellHook = ''
            rustup toolchain install stable --no-self-update
            rustup default stable
          '';
        };

        jvm = pkgs.mkShell {
          buildInputs = with pkgs; [ jdk21 jdk25 gradle_9 ];
          JAVA_HOME = "${pkgs.jdk21}";
        };

        node = pkgs.mkShell {
          buildInputs = with pkgs; [ nodejs ];
        };
      };
    };
}
