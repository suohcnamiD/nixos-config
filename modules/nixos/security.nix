{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ keepassxc openssl ];
  security.sudo.extraConfig = ''
    Defaults env_keep += "DISPLAY XAUTHORITY WAYLAND_DISPLAY"
  '';
}
