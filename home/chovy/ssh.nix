{ config, pkgs, ... }: {


  sops.secrets = {
  	"ssh/stachetopia/key" = {
  	  	path = "/home/chovy/.ssh/stachetopia";
  	  	mode = "0600";
  	};
  	
  	"ssh/stachetopia/user" = {
  	  	mode = "0600";
	};

	"ssh/stachetopia/host" = {
	  	mode = "0600";
  	};

  	"ssh/oracle/key" = {
  	  	path = "/home/chovy/.ssh/oracle";
  	  	mode = "0600";
  	};
  	
  	"ssh/oracle/user" = {
  	  	mode = "0600";
	};

	"ssh/oracle/host" = {
	  	mode = "0600";
  	};
  };

  sops.templates."ssh-identities".content = ''
	Host stachetopia
	  HostName ${config.sops.placeholder."ssh/stachetopia/host"}
	  User ${config.sops.placeholder."ssh/stachetopia/user"}
	  IdentityFile ${config.sops.secrets."ssh/stachetopia/key".path}
	  AddKeysToAgent yes
 	Host oracle
 	  HostName ${config.sops.placeholder."ssh/oracle/host"}
 	  User ${config.sops.placeholder."ssh/oracle/user"}
 	  IdentityFile ${config.sops.secrets."ssh/oracle/key".path}
 	  AddKeysToAgent yes
  '';
  
  programs.ssh = {
  	enable = true;
  	extraConfig = ''
	  Include ${config.sops.templates."ssh-identities".path}
  	'';
  };
}
