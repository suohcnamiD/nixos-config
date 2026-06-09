{ config, pkgs, pkgs-unstable, ... }: {

  # These must match your actual username and home directory path.
  home.username      = "chovy";
  home.homeDirectory = "/home/chovy";

  # Personal packages — tools only you need, not the whole system.
  home.packages = with pkgs; [
    ripgrep    # better grep — search through files with rg
    fd         # better find — find files with fd
    bat        # better cat — view files with syntax highlighting
    htop       # interactive process viewer
  ];

  # home-manager version — like system.stateVersion, set this once and never change it.
  home.stateVersion = "26.05";

  # This line lets home-manager manage its own configuration and updates.
  programs.home-manager.enable = true;
}
