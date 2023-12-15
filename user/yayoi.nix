{ pkgs, ... }: {
	users.users.yayoi = {
		uid = 10000;
		group = "users";
		isNormalUser = true;
		home = "/home/guest";
		shell = pkgs.fish;
		hashedPasswordFile = "/@/yayoi.pass";
		extraGroups = [ ];
	};
}
