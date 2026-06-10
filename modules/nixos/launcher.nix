{  pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wmctrl
    ulauncher
  ]
}
