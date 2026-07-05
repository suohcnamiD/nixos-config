{ config, pkgs, ... }: {
  virtualisation.docker.enable = true;

  nixpkgs.config.android_sdk.accept_license = true;

  networking.extraHosts = ''
	127.0.0.1 alpha.localhost
	127.0.0.1 beta.localhost
	127.0.0.1 gamma.localhost

  '';
  
  environment.etc."docker/certs.d/dev.stachetopia/hosts.toml".text = ''
    server = "http://dev.stachetopia"
  
    [host."http://dev.stachetopia"]
      capabilities = ["pull", "resolve", "push"]
  '';

  virtualisation.docker.daemon.settings = {
    insecure-registries = [ "dev.stachetopia" ];
  };
  
  environment.systemPackages = with pkgs; [ 
    dnsutils
    pkgs.jetbrains.idea
    vscodium
    micro
    jdk25
    jdk21
	gradle_9
	bruno
	elmPackages.nodejs
  ];
  environment.variables.EDITOR = "micro";

  
  users.users.chovy.extraGroups = [ "docker" ];
  	
}
