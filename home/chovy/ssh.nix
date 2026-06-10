{ pkgs, ... }: {
  services.ssh-agent.enable = true;
  programs.ssh.enableDefaultConfig = false;
  programs.ssh = {
  	enable = true;
  	settings = {
 	  "stachetopia" = {
 	    AddKeysToAgent = "yes";
 	  	hostname = "135.181.177.107";
 	  	user = "root";
 		identityFile = "~/.ssh/stachetopia";
	  };
  	};
  };
}
