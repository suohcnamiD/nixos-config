{ config, pkgs, ... }: {
  programs.gpaste.enable = true;
  environment.systemPackages = with pkgs; [
    gpaste
    python313Packages.simpleeval
    python313Packages.pint
    chezmoi
  ];
}
