{ config, pkgs, lib, ... }: {

  networking.wg-quick.interfaces = {
    wg0.configFile = "/etc/wireguard/wg0.conf";
  };

  networking.networkmanager.wifi.powersave = false;

  # Intentionally not auto-started — run `systemctl start wg-quick-wg0` when needed.
  systemd.services."wg-quick-wg0".wantedBy = lib.mkForce [ ];

  services.tailscale = {
  	enable = true;
  	extraSetFlags = [ "--netfilter-mode=nodivert" ];
  };

  environment.systemPackages = with pkgs; [
  	openconnect
  	seclists
  	nmap
  	ffuf
  	gobuster
  	feroxbuster
  	hydra
  	medusa
  	masscan
  	nikto
  	sqlmap
  	wfuzz
  	amass
  	subfinder
  	
  ]; 
  
  networking.firewall = {
   	enable = true;
   	trustedInterfaces = [ "tailscale0" ];
 	allowedUDPPorts = [ config.services.tailscale.port ];
   	allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
  	allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
  	checkReversePath = "loose";
  };
}
