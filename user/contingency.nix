{ pkgs, ... }: {
	users.users.contingency = {
		uid = 100;
		isSystemUser = true;
		home = "/home/heart";
		useDefaultShell = true;
		createHome = true;
	};
}
