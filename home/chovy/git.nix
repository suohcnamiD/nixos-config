{
	programs.git = {
		enable = true;
		extraConfig = {
			"credential \"https://github.com\"".helper = 
				"!f() { echo password=$*(cat /run/secrets/git/stachetopia/token); }; f";
		};
	};
}
