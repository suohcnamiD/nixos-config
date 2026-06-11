{ config, pkgs, lib, ... }: {

  # 1. Register the raw secrets
  sops.secrets."git/forgejo/username" = { };
  sops.secrets."git/forgejo/token" = { };

  # 2. Define the template (Leave out the custom path option!)
  sops.templates."gradle.properties".content = ''
    stachetopia.packages.publishing.username=${config.sops.placeholder."git/forgejo/username"}
    stachetopia.packages.publishing.token=${config.sops.placeholder."git/forgejo/token"}
    stachetopia.packages.installing.username=${config.sops.placeholder."git/forgejo/username"}
    stachetopia.packages.installing.token=${config.sops.placeholder."git/forgejo/token"}
  '';

  # 3. Cleanly drop a symlink during generation activation
  home.activation.linkGradleProperties = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p $HOME/.gradle
    ln -sf "${config.sops.templates."gradle.properties".path}" "$HOME/.gradle/gradle.properties"
  '';
}
