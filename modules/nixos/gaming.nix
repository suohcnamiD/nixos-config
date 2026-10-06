{ pkgs, ... }: {
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
  };

  hardware.xone.enable = true;

  services.asusd = {
    enable = true;
  };

  services.udev.extraRules = ''
    ATTR{vendor}=="0x10de", TAG+="mutter-device-preferred-primary"
    KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
  '';
  users.users.chovy.extraGroups = [ "input" ];

  environment.systemPackages = with pkgs; [
    lutris
    egl-wayland
    gamescope_git
    winetricks
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs.gamescope.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

  programs.steam = {
    enable = true;
  };

  environment.sessionVariables.VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json";


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
