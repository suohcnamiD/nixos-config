{ config, pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  services.pipewire = {
    enable = true;
    wireplumber.extraConfig = {
      "10-bluez-fix" = {
        "monitor.bluez.properties" = {
          "bluez5.codecs" = [ "sbc" "sbc_xq" "aac" ];
          "bluez5.roles" = [ "a2dp_sink" "a2dp_source" "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
        };
      };
    };
  };
}
