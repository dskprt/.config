{ pkgs, ... }: {
	users.users.contingency = {
		uid = 100;
		group = "contingency";
		isSystemUser = true;
		home = "/home/heart";
		useDefaultShell = true;
		createHome = true;
	};

	users.groups.contingency = {};
}
