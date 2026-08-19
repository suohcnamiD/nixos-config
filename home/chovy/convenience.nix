{ pkgs, ... }: {
	home.packages = with pkgs; [
		open-scq30
	];
}
