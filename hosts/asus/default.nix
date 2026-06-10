{ config, pkgs, lib, ... }: {

  imports = [
    # Load the hardware config that was auto-generated at install time.
    # This path is relative to THIS file, so ./hardware.nix means
    # hosts/laptop/hardware.nix — which is in the same directory.
    ./hardware.nix

    # Load modules/nixos/default.nix (the index file for the nixos modules folder).
    # The path ../../modules/nixos is relative to THIS file:
    #   start at hosts/laptop/
    #   go up two levels to ~/nixos-config/
    #   then down into modules/nixos/
    # Pointing at a directory automatically loads the default.nix inside it.
    ../../modules/nixos
  ];

  sops.secrets."ssh/stachetopia" = {
  	path = "/home/chovy/.ssh/stachetopia";
  	owner = "chovy";
  	mode = "0600";
  };
  
  sops.secrets."git/github/username" = {
  	owner = "chovy";
  	mode = "0600";
  };
  
  sops.secrets."git/github/token" = {
  	owner = "chovy";
  	mode = "0600";
  };

  sops.age.keyFile = "/home/chovy/.config/sops/age/keys.txt";
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  
  # ── Boot ──────────────────────────────────────────────────────────────────
  boot.loader.systemd-boot.enable      = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ── Networking ────────────────────────────────────────────────────────────
  # This must exactly match the name used in flake.nix (nixosConfigurations.laptop)
  networking.hostName              = "asus";
  networking.networkmanager.enable = true;

  # ── Locale & time ─────────────────────────────────────────────────────────
  time.timeZone      = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  # ── Desktop (GNOME) ───────────────────────────────────────────────────────
  services.xserver.enable                      = true;
  services.xserver.displayManager.gdm.enable   = true;
  services.xserver.desktopManager.gnome.enable = true;

  # ── Sound ─────────────────────────────────────────────────────────────────
  hardware.pulseaudio.enable = false;  # use pipewire instead
  security.rtkit.enable      = true;
  services.pipewire = {
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    pulse.enable      = true;  # makes apps that expect pulseaudio work via pipewire
  };

  # ── Users ─────────────────────────────────────────────────────────────────
  users.users.chovy = {
    isNormalUser = true;
    extraGroups  = [ "wheel" "networkmanager" ];  # "wheel" grants sudo access
    shell        = pkgs.bash;
  };

  # ── System packages ───────────────────────────────────────────────────────
  # These are available to all users. Keep this list small.
  # Personal tools belong in home/alice/laptop.nix instead.
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
  ];

  # ── Nix settings ──────────────────────────────────────────────────────────
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Automatically delete old generations once a week to free disk space.
  nix.gc = {
    automatic = true;
    dates     = "weekly";
    options   = "--delete-older-than 14d";
  };

  # ── IMPORTANT: do not change this value ───────────────────────────────────
  # This is NOT the NixOS version. It controls backwards-compatibility
  # behavior for stateful data (databases, home directories, etc.).
  # Set it to the value from your current /etc/nixos/configuration.nix
  # and never change it, even when upgrading NixOS.
  system.stateVersion = "26.05";
}
