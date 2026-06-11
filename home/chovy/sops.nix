{ ... }: {
    sops.age.keyFile = "/home/chovy/.config/sops/age/keys.txt";
    sops.defaultSopsFile = ../../secrets/secrets.yaml;
}
