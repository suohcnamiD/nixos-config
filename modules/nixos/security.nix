{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ keepassxc ];
  security.sudo.extraConfig = ''
    Defaults env_keep += "DISPLAY XAUTHORITY WAYLAND_DISPLAY"
  '';
}
