{
	programs.git = {
		enable = true;
		settings = {
			"credential \"https://github.com\"".helper = 
				"!f() { echo password=$(cat /run/secrets/git/github/token); echo username=$(cat /run/secrets/git/github/username); }; f";
		};
		settings.user = {
			name = "Chovy";
			email = "veryverychovy@proton.me";
		};
	};

	sops.secrets = {
	  	"git/github/username" = {
	  	  	owner = "chovy";
	  	  	mode = "0600";
	 	};

	 	"git/github/token" = {
	 	  	owner = "chovy";
	 	  	mode = "0600";
	 	};
	};
}
