{ pkgs, ... }: {
  home.packages = with pkgs; [
    jetbrains.idea
    jetbrains.rust-rover
    vscodium
    blockbench
    dbeaver-bin
    android-studio
    chromium
    cmake
    buf
    go
  ];

  nixpkgs.config.android_sdk.accept_license = true;

  home.file = {
    ".jdks/jdk21".source = pkgs.jdk21;
    ".jdks/jdk25".source = pkgs.jdk25;
  };
}
