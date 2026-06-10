{  pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wmctrl
    ulauncher
  ];
  systemd.user.services.ulauncher = {
    description = "Ulauncher application launcher";
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.ulauncher}/bin/ulauncher --hide-window";
      Restart = "on-failure";
    };
  };
}
