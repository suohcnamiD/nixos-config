{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    firefox
  ];

  home-manager.sharedModules = [{
  	xdg.mimeApps = {
  	  enable = true;
  	  defaultApplications = {
  	  	"text/html" = "firefox.desktop";
  	  	"x-scheme-handler/http" = "firefox.desktop";
  	  	"x-scheme-handler/https" = "firefox.desktop";
  	  };
  	};
  }];
  
}
