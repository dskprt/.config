{
	environment.persistence."/@" = {
		directories = [
			"/etc/nixos"
			"/etc/libvirt/hooks"
			"/etc/NetworkManager"
			"/var/log"
		];
		files = [
			"/etc/machine-id"
			"/etc/nix/id_rsa"
		];
	};
}
