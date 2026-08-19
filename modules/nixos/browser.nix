{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    firefox
  ];
  
  environment.sessionVariables = {
    # Forces Firefox to use XWayland — fixes input lag in browser-based games under native Wayland.
    MOZ_ENABLE_WAYLAND = "0";
  };

}
