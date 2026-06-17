{ inputs, pkgs, ... }: {

	home.packages = with pkgs; [
		blockbench
		dbeaver-bin
	];
	home.file = {
	    ".jdks/jdk21".source = pkgs.jdk21;
	    ".jdks/jdk25".source = pkgs.jdk25;
    };
}
