{ pkgs, ... }: {
	home.packages = with pkgs; [
	  shotcut
	  inkscape
	  libreoffice-fresh
	  frei0r
	  davinci-resolve
	  gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
    obs-studio
	];

	systemd.user.sessionVariables = {
	  GST_PLUGIN_PATH = "${pkgs.gst_all_1.gstreamer}/lib/gstreamer-1.0";
	};
}
