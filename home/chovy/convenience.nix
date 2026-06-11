{ pkgs, ... }: {
	dconf.settings = {
	    "org/gnome/shell" = {
	      disable-user-extensions = false;
	      enabled-extensions = [ pkgs.gnomeExtensions.gsconnect.extensionUuid ];
	    };
	  };
}
