{ pkgs, ... }: {
	users.users.commander = {
		uid = 1000;
		group = "users";
		isNormalUser = true;
		home = "/home/cmdr";
		shell = pkgs.fish;
		hashedPasswordFile = "/@/commander.pass";
		extraGroups = [ "wheel" ];
	};
}
