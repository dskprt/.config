{ pkgs, ... }: {
	users.users.commander = {
		uid = 1000;
		group = "users";
		isNormalUser = true;
		home = "/home/cmdr";
		shell = pkgs.fish;
		hashedPasswordFile = "/var/commander.pass";
		extraGroups = [ "wheel" ];

		openssh.authorizedKeys.keys = [
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMCgo+2yFgSlrX2KV2jnG2yb2T5eAroA9TQ7/puKL6ql kiso@workbench"
		];
	};
}
