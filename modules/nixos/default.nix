{ config, pkgs, ... }: {
  imports = [
    ./appearance.nix 
    ./development.nix
    ./gnome.nix
    ./browser.nix
    ./networking.nix
    ./launcher.nix
    ./social.nix
    ./security.nix
    ./convenience.nix 
  ];
  environment.systemPackages = with pkgs; [
    wget
    curl 
    git
    gst_all_1.gstreamer
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
        ];
      });
    })
  ];

}
