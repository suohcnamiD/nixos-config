{ config, pkgs, ... }: {
  programs.gpaste.enable = true;
  environment.systemPackages = with pkgs; [
    gpaste
    python3
    chezmoi
    geary
    gnomeExtensions.gsconnect
    gnomeExtensions.quick-lang-switch
  ];
  
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
  environment.extraInit = ''
    export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
  '';
}
