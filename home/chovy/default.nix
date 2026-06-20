{ inputs, config, pkgs, pkgs-unstable, lib, ... }: 

{

  imports = [
    ./gaming.nix
    ./ssh.nix
    ./git.nix
    ./sops.nix
    ./development.nix
    ./convenience.nix
    ./appearance.nix
    ./gradle.nix
    ./editing.nix
  ];

  xdg.configFile."micro/settings.json" = {
  	force = true;
  	text = builtins.toJSON {
  	  clipboard = "external";	
  	};
  };

  # These must match your actual username and home directory path.
  home.username      = "chovy";
  home.homeDirectory = "/home/chovy";

  # Personal packages — tools only you need, not the whole system.
  home.packages = with pkgs; [
    ripgrep    # better grep — search through files with rg
    fd         # better find — find files with fd
    bat        # better cat — view files with syntax highlighting
    htop       # interactive process viewer
    btop 	   # an even better one xd
  ];

  # home-manager version — like system.stateVersion, set this once and never change it.
  home.stateVersion = "26.05";

  services.mako.enable = true;


  home.sessionVariables = {
  	XDG_DATA_DIRS = "/run/current-system/sw/share:$XDG_DATA_DIRS";
  };

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ulauncher/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/gpaste/"
      ];
    };
    
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ulauncher" = {
      binding = "<Control>space";
      command = "ulauncher-toggle";
      name = "Open Ulauncher";
    };
    
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/gpaste" = {
      binding = "<Super>v";
      command = "gpaste-client ui";
      name = "Open GPaste";
    };
  };

}
