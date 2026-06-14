{ ... }: {

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
  };

  programs.gamescope.enable = true;
  
  services.xserver.videoDrivers = [ "nvidia" ];


  programs.steam = {
    enable = true;
  };
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
