{ config, pkgs, ... }: {
  environment.gnome.excludePackages = with pkgs; [ 
    gnome-contacts
    gnome-characters
    gnome-tour
    yelp
  ];
  documentation.nixos.enable = false;
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    dconf-editor
  ];

  xdg.mime.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };
}
