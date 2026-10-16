{ pkgs, ...}: {

  home.packages = [
    (pkgs.prismlauncher.override {
      additionalLibs = [ pkgs.libGL ];
    })
  ];
}
