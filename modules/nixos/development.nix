{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ 
    pkgs.jetbrains.idea
    vscodium
  ];
}
