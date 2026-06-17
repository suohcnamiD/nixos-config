{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    firefox
  ];
  
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "0";
  };

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
