{ pkgs, ... }: {
	home.packages = with pkgs; [
	  kdePackages.kdenlive
	  inkscape
	  libreoffice-fresh
	  frei0r
	  python3
	];
}
