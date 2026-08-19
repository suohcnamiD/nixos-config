{ pkgs, ... }: {
	home.packages = with pkgs; [
	  shotcut
	  inkscape
	  libreoffice-fresh
	  frei0r
	  davinci-resolve
	  obs-studio
	];
}
