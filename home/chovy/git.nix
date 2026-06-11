{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    settings = {
      "credential \"https://github.com\"".helper = 
        "!f() { echo password=$(cat ${config.sops.secrets."git/github/token".path}); echo username=$(cat ${config.sops.secrets."git/github/username".path}); }; f";
    };
    settings.user = {
      name = "Chovy";
      email = "veryverychovy@proton.me";
    };
  };

  sops.secrets = {
    "git/github/username" = {
      mode = "0600";
    };

    "git/github/token" = {
      mode = "0600";
    };
  };
}
