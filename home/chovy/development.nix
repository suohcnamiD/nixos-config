{ inputs, pkgs, ... }: {

	home.packages = with pkgs; [
		blockbench
		dbeaver-bin
		elmPackages.nodejs
		android-studio
		chromium
		cmake
		buf
		go
	];

	nixpkgs.config.android_sdk.accept_license = true;
	
	home.file = {
	    ".jdks/jdk21".source = pkgs.jdk21;
	    ".jdks/jdk25".source = pkgs.jdk25;
    };
}
