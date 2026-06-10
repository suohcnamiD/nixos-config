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
  ];
  environment.systemPackages = with pkgs; [
    wget
    curl 
    git
  ];
  nixpkgs.config.allowUnfree = true;
}
