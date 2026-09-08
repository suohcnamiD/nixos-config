{
	description = "Chovy's NixOS";

	inputs = {
	  chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
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

	  fenix = {
	    url = "github:nix-community/fenix";
	    inputs.nixpkgs.follows = "nixpkgs";
	  };
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, sops-nix, fenix, ... }@inputs:
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
            inputs.chaotic.nixosModules.default
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
        dioxus = let
          rustToolchain = fenix.packages.${system}.combine [
            fenix.packages.${system}.stable.toolchain
            fenix.packages.${system}.targets.wasm32-unknown-unknown.stable.rust-std
          ];
	    		wasm-bindgen-cli-127 = pkgs.rustPlatform.buildRustPackage rec {
	    		  pname = "wasm-bindgen-cli";
	    		  version = "0.2.127";
	    		  src = pkgs.fetchCrate {
	    		    inherit pname version;
	    		    hash = "sha256-di+qBAdd7pENLiIB9CoZoab+W5xeDoByMREcCGTSzWo=";
	    		  };
	    		  cargoHash = "sha256-FTv2GZIAQs0ePdIZXIXil7JbZ6kIT05VG6vqC1qNFxQ=";
	    		  nativeBuildInputs = [ pkgs.pkg-config ];
	    		  buildInputs = [ pkgs.openssl ] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [ pkgs.libiconv ];
	    		  checkType = "debug";
	    		  # tests may need network/browser, often disabled:
	    		  doCheck = false;
	    		};
          in pkgs.mkShell {
            buildInputs = [
              rustToolchain
              pkgs.pkg-config
              pkgs.openssl
              pkgs.dioxus-cli
              pkgs.sass
	        	  wasm-bindgen-cli-127

              # desktop (Tauri/webview) build deps
              pkgs.webkitgtk_4_1
              pkgs.gcc
              pkgs.gnumake
              pkgs.curl
              pkgs.wget
              pkgs.file
              pkgs.xdotool          # provides libxdo
              pkgs.libayatana-appindicator
              pkgs.librsvg
              pkgs.lld
            ];

            PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.webkitgtk_4_1.dev}/lib/pkgconfig:${pkgs.libayatana-appindicator}/lib/pkgconfig:${pkgs.librsvg.dev}/lib/pkgconfig";
            OPENSSL_DIR     = "${pkgs.openssl.dev}";
            OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
          };
	    
	      leptos = let
	        rustToolchain = fenix.packages.${system}.combine [
            fenix.packages.${system}.stable.toolchain
            fenix.packages.${system}.targets.wasm32-unknown-unknown.stable.rust-std
          ];
	    		wasm-bindgen-cli-127 = pkgs.rustPlatform.buildRustPackage rec {
	    		  pname = "wasm-bindgen-cli";
	    		  version = "0.2.127";
	    		  src = pkgs.fetchCrate {
	    		    inherit pname version;
	    		    hash = "sha256-di+qBAdd7pENLiIB9CoZoab+W5xeDoByMREcCGTSzWo=";
	    		  };
	    		  cargoHash = "sha256-FTv2GZIAQs0ePdIZXIXil7JbZ6kIT05VG6vqC1qNFxQ=";
	    		  nativeBuildInputs = [ pkgs.pkg-config ];
	    		  buildInputs = [ pkgs.openssl ] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [ pkgs.libiconv ];
	    		  checkType = "debug";
	    		  # tests may need network/browser, often disabled:
	    		  doCheck = false;
	    		};
	      in pkgs.mkShell {
	        buildInputs = [ 
	        	rustToolchain 
	        	pkgs.pkg-config 
	        	pkgs.openssl 
	        	pkgs.cargo-leptos
	        	pkgs.leptosfmt
	        	wasm-bindgen-cli-127
	        	pkgs.trunk
	        	pkgs.sass
	        ];
	        
	        PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
	        OPENSSL_DIR     = "${pkgs.openssl.dev}";
	        OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
	      };
	      
	      rust = let
	        toolchain = inputs.fenix.packages.${system}.stable.toolchain;
	      in pkgs.mkShell {
	        buildInputs = [ toolchain pkgs.pkg-config pkgs.openssl pkgs.cargo-leptos ];
	        PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
	        OPENSSL_DIR     = "${pkgs.openssl.dev}";
	        OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
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
