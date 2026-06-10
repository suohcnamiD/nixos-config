{ config, pkgs, ... }: {
  imports = [
    ./appearance.nix 
    ./development.nix
    ./gnome.nix
    ./browser.nix
    ./networking.nix
    ./launcher.nix
    ./social.nix
    ./security.nix
    ./convenience.nix 
  ];
  environment.systemPackages = with pkgs; [
    wget
    curl 
    git
    wl-clipboard
  ];
  nixpkgs.config.allowUnfree = true;
}
