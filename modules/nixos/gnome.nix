{ config, pkgs, ... }: {
  environment.gnome.excludePackages = with pkgs; [ 
    gnome-contacts
    gnome-characters
    gnome-tour
    yelp
  ];
  documentation.nixos.enable = false;
}
