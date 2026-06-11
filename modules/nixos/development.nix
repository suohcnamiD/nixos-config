{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ 
    pkgs.jetbrains.idea
    vscodium
    micro
    jdk25
    jdk21
	gradle
  ];
  environment.variables.EDITOR = "micro";
}
