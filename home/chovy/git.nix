{
	programs.git = {
		enable = true;
		extraConfig = {
			"credential \"https://github.com\"".helper = 
				"!f() { echo password=$(cat /run/secrets/git/github/token); echo username=$(cat /run/secrets/git/github/username); }; f";
		};
	};
}
