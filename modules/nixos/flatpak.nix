{ inputs, ... }: {
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  services.flatpak = {
    enable = true;
    packages = [ "org.vinegarhq.Sober" ];
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
