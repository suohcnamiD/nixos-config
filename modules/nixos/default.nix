{ config, pkgs, ... }: {
  imports = [ ./development.nix ];
  environment.systemPackages = with pkgs; [
    wget
    curl 
    git
  ];
}
