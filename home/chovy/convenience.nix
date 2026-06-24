{ pkgs, ... }: {

	home.packages = with pkgs; [
		open-scq30
		appflowy
	];

	dconf.settings = {
	    "org/gnome/shell" = {
	      disable-user-extensions = false;
	      enabled-extensions = [ 
	        pkgs.gnomeExtensions.gsconnect.extensionUuid
            pkgs.gnomeExtensions.quick-lang-switch.extensionUuid
            "GPaste@gnome-shell-extensions.gnome.org" 
	      ];
	    };
	  };
}
