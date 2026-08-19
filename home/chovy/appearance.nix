{ pkgs, ... }: {
	dconf.settings = {
	    "org/gnome/shell" = {
	      disable-user-extensions = false;
	      enabled-extensions = [
	        pkgs.gnomeExtensions.blur-my-shell.extensionUuid
	        pkgs.gnomeExtensions.gsconnect.extensionUuid
	        pkgs.gnomeExtensions.quick-lang-switch.extensionUuid
	        "GPaste@gnome-shell-extensions.gnome.org"
	      ];
	    };

	    "org/gnome/shell/extensions/blur-my-shell" = {
	      brightness = 0.6;
	      sigma = 30;
	    };

	    "org/gnome/shell/extensions/blur-my-shell/panel" = {
	      blur = true;
	      brightness = 0.6;
	      sigma = 30;
	    };

	    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
	      blur = true;
	      static-blur = true;
	      brightness = 0.6;
	      sigma = 30;
	    };
	  };
}
