{ config, pkgs, ... }: {
  programs.gpaste.enable = true;
  environment.systemPackages = with pkgs; [
    gpaste
    python3
    chezmoi
    geary
    gnomeExtensions.gsconnect
    gnomeExtensions.quick-lang-switch
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
  ];
  
  environment.variables = {
      GST_PLUGIN_PATH = "/run/current-system/sw/lib/gstreamer-1.0/";
  };

  services.flatpak = {
    packages = [ "io.appflowy.AppFlowy" ];
  };
  
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
  environment.extraInit = ''
    export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
  '';

  
}
