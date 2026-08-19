{ config, pkgs, ... }: {
  # Enable CUPS printing service
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ]; # Adds HP Officejet 6600 support
  };

  # Optional: Enable network discovery (highly recommended if on Wi-Fi/Ethernet)
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Optional: Enable scanner support
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplip ];
  };

  # Make sure your user is in the right groups to print and scan
  users.users.chovy.extraGroups = [ "scanner" "lp" ];
}
