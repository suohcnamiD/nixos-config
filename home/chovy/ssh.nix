{ pkgs, ... }: {
  services.ssh-agent.enable = true;
  programs.ssh = {
  	enable = true;
  	addKeysToAgent = "yes";
  	matchBlocks = {
 	  "stachetopia" = {
 	  	hostname = "135.181.177.107";
 	  	user = "root";
 		identityFile = "~/.ssh/stachetopia";
	  };
  	};
  };
}
