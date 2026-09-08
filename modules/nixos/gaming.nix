{ pkgs, ... }: {
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
  };

  services.asusd = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    lutris
    egl-wayland
    gamescope_git
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs.gamescope.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

  programs.steam = {
    enable = true;
  };

  environment.sessionVariables.VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json";

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
    extraPackages = with pkgs; [ egl-wayland ];
  };
}
