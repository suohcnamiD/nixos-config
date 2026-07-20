{ inputs, ... }: {

  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
  
  services.flatpak = {
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

  services.udev.extraRules = ''
    ATTR{vendor}=="0x10de", TAG+="mutter-device-preferred-primary"
  '';

  hardware.nvidia.prime = {
    amdgpuBusId = "PCI:4:0:0";
    nvidiaBusId = "PCI:1:0:0";
    offload.enable = true;
    offload.enableOffloadCmd = true;
  };
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
