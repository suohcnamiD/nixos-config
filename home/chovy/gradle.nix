{ config, lib, ... }: {

  sops.templates."gradle.properties".content = ''
    stachetopia.packages.publishing.username=${config.sops.placeholder."git/forgejo/username"}
    stachetopia.packages.publishing.token=${config.sops.placeholder."git/forgejo/token"}
    stachetopia.packages.installing.username=${config.sops.placeholder."git/forgejo/username"}
    stachetopia.packages.installing.token=${config.sops.placeholder."git/forgejo/token"}
  '';

  home.activation.linkGradleProperties = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p $HOME/.gradle
    ln -sf "${config.sops.templates."gradle.properties".path}" "$HOME/.gradle/gradle.properties"
  '';
}
