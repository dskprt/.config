{
	environment.persistence."/@" = {
		directories = [
			"/etc/nixos"
			"/etc/libvirt"
			"/etc/NetworkManager"
			"/var/log"
			"/var/lib/libvirt"
		];
		files = [
			"/etc/machine-id"
			"/etc/nix/id_rsa"
		];
	};
}
