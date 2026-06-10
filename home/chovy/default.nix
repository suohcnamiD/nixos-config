{ config, pkgs, pkgs-unstable, lib, ... }: 

let
  ulauncherLiquidGlass = pkgs.fetchFromGitHub {
    owner  = "kayozxo";
    repo   = "ulauncher-liquid-glass";
    rev    = "e8fc1ef2aa137d177202a0c26d23ed2ef82db8d4";
    sha256 = "sha256-arWNy69rmZvHhWWxqBuJxg6+B1YM1iFOoW734j6VCxs=";
  };
in

{

  imports = [
    ./gaming.nix
  ];

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

  home.activation.ulauncherTheme = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "$HOME/.config/ulauncher/user-themes"
    cp -r --no-preserve=mode ${ulauncherLiquidGlass}/liquid-glass-dark \
      "$HOME/.config/ulauncher/user-themes/liquid-glass-dark"
  '';

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [ pkgs.gnomeExtensions.blur-my-shell.extensionUuid ];
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = true;
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      static-blur = true;
      brightness = 0.6;
      sigma = 30;
    };
  };

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control>space";
      command = "ulauncher-toggle";
      name = "Open Ulauncher";
    };
  };

}
