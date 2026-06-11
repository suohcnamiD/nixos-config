{ config, pkgs, ... }: {
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [ 
    pkgs.jetbrains.idea
    vscodium
    micro
    jdk25
    jdk21
	gradle_9
	bruno
  ];
  environment.variables.EDITOR = "micro";

  
  users.users.chovy.extraGroups = [ "docker" ];
  	
}
