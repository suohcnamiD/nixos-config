{ pkgs, ... }: {
	virtualisation.libvirtd = {
	  enable = true;
	  qemu = {
	    swtpm.enable = true;
	  };
	};

	virtualisation.spiceUSBRedirection.enable = true;

	users.groups.libvirtd.members = [ "chovy" ];
	users.groups.kvm.members = [ "chovy" ];

	environment.systemPackages = with pkgs; [
	  gnome-boxes
	  dnsmasq
	];
}
