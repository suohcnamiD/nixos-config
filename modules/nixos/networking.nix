{ config, ... }: {
  services.tailscale = {
  	enable = true;
  	extraSetFlags = [ "--netfilter-mode=nodivert" ];
  };

  
  networking.firewall = {
   	enable = true;
   	trustedInterfaces = [ "tailscale0" ];
 	allowedUDPPorts = [ config.services.tailscale.port ];
   	allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
  	allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
  	checkReversePath = "loose";
  };
}
