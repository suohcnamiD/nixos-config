{ pkgs, ... }: {
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
  };

  services.asusd = {
    enable = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

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
