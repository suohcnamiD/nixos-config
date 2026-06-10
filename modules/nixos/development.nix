{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ 
    pkgs.jetbrains.idea
    vscodium
    micro
  ];
  environment.variables.EDITOR = "micro";
}
