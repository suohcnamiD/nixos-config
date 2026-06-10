{ config, pkgs, ... }: {
  programs.gpaste.enable = true;
  environment.systemPackages = with pkgs; [
    gpaste
  ];
}
