{
	environment.persistence."/var/persist" = {
		directories = [
			"/etc/nixos"
			"/etc/NetworkManager"
		];
		files = [
			"/etc/machine-id"
			"/etc/nix/id_rsa"
		];
	};
}
