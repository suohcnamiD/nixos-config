{ ... }: {
  virtualisation.docker.enable = true;

  virtualisation.docker.daemon.settings = {
    insecure-registries = [ "dev.stachetopia" ];
  };

  environment.etc."docker/certs.d/dev.stachetopia/hosts.toml".text = ''
    server = "http://dev.stachetopia"

    [host."http://dev.stachetopia"]
      capabilities = ["pull", "resolve", "push"]
  '';

  users.users.chovy.extraGroups = [ "docker" ];
}
