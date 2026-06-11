{ config, ... }: {

  # 1. Register the raw Forgejo secrets from your YAML hierarchy
  sops.secrets."git/forgejo/username" = { };
  sops.secrets."git/forgejo/token" = { };

  # 2. Map them directly into Gradle's global configuration file
  sops.templates."gradle.properties" = {
    path = "${config.home.homeDirectory}/.gradle/gradle.properties";
    content = ''
      stachetopia.packages.publishing.username=${config.sops.placeholder."git/forgejo/username"}
      stachetopia.packages.publishing.token=${config.sops.placeholder."git/forgejo/token"}
      stachetopia.packages.installing.username=${config.sops.placeholder."git/forgejo/username"}
      stachetopia.packages.installing.token=${config.sops.placeholder."git/forgejo/token"}
    '';
  };
}
