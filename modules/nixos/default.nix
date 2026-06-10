{ config, pkgs, ... }: {
  imports = [ 
    ./development.nix
    ./gnome.nix
    ./browser.nix
    ./networking.nix
    ./launcher.nix 
  ];
  environment.systemPackages = with pkgs; [
    wget
    curl 
    git
  ];
  nixpkgs.config.allowUnfree = true;
}
