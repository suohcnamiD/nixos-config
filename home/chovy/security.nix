{ pkgs, ...}: {
  security.pki.certificateFiles = [
    /home/chovy/nixos-config/certs/root.crt
  ];
}
