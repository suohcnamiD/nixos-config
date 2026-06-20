{ pkgs, ... }: {

	home.packages = with pkgs; [
		open-scq30
	];

	dconf.settings = {
	    "org/gnome/shell" = {
	      disable-user-extensions = false;
	      enabled-extensions = [ 
	        pkgs.gnomeExtensions.gsconnect.extensionUuid
	        pkgs.gnomeExtensions.grand-theft-focus.extensionUuid
            "GPaste@gnome-shell-extensions.gnome.org" 
	      ];
	    };
	  };
}
