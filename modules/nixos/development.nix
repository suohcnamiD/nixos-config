{ config, pkgs, ... }: {
  virtualisation.docker.enable = true;

  boot = {
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="AndroidCam" video_nr=5
    '';
  };

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
    jetbrains.idea
    jetbrains.rust-rover
    rustup
    rustc
    vscodium
    micro
    jdk25
    jdk21
	gradle_9
	bruno
	elmPackages.nodejs
	gcc
	openapi-generator-cli
	pkg-config
	openssl
	protobuf
	alsa-plugins
	scrcpy
	android-tools
	v4l-utils
	gnumake
  ];
  environment.variables.EDITOR = "micro";

  
  users.users.chovy.extraGroups = [ "docker" ];
  	
}
