{ config, pkgs, ... }: {
  nixpkgs.config.android_sdk.accept_license = true;

  environment.systemPackages = with pkgs; [
    dnsutils
    micro
    jdk25
    jdk21
    gradle_9
    bruno
    gcc
    openapi-generator-cli
    protobuf
    alsa-plugins
    android-tools
    gnumake
  ];

  environment.variables.EDITOR = "micro";
}
