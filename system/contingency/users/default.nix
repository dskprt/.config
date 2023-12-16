{ pkgs, ... }: {
	imports = [
		../../../user/commander.nix
		../../../user/contingency.nix
	];

	users.mutableUsers = false;
	users.motdFile = "/var/motd";
}
