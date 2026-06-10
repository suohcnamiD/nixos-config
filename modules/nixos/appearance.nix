{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.gnomeExtensions.blur-my-shell
  ];
}
