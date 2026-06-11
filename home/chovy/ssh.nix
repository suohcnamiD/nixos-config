{ pkgs, ... }: {


  sops.secrets = {
  	"ssh/stachetopia/key" = {
  	  	path = "/home/chovy/.ssh/stachetopia";
  	  	owner = "chovy";
  	  	mode = "0600";
  	};
  	
  	"ssh/stachetopia/user" = {
  	  	owner = "chovy";
  	  	mode = "0600";
	};

	"ssh/stachetopia/host" = {
	  	owner = "chovy";
	  	mode = "0600";
  	};
  };

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
