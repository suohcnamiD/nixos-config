{ config, pkgs, ... }: {
  imports = [
    ./appearance.nix 
    ./development.nix
    ./docker.nix
    ./gnome.nix
    ./browser.nix
    ./networking.nix
    ./launcher.nix
    ./social.nix
    ./security.nix
    ./desktop.nix
    ./gaming.nix
    ./virtualization.nix
    ./flatpak.nix
    ./ai.nix
    ./printing.nix
    ./media.nix
    ./remote.nix
    ./sound.nix
  ];
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    wl-clipboard
    libnotify
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (final: prev: {
      ulauncher = prev.ulauncher.overrideAttrs (oldAttrs: {
        # This appends 'pint' right into Ulauncher's internal Python path
        propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [
          final.python3Packages.pint
          final.python3Packages.simpleeval
          final.python3Packages.uuid6
          final.python3Packages.bcrypt
        ];
      });
    })
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Fix for copilot in IDEA not working - something with unpatched dynamic binaries
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries here if Copilot complains later
    stdenv.cc.cc
    zlib
    glibc
  ];

}
