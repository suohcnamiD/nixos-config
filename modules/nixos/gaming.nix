{ inputs, ... }: {

  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
  
  services.flatpak = {
    enable = true;
    packages = [ "org.vinegarhq.Sober" ];
  };

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
