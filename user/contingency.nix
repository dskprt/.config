{ pkgs, ... }: {
	users.users.contingency = {
		uid = 100;
		group = "users";
		isNormalUser = true;
		home = "/home/heart";
		shell = pkgs.sh;
	};
}
