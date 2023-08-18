{ pkgs, ... }: {
	users.users.skk = {
		isNormalUser = true;
		home = "/home/commander";
		shell = pkgs.fish;
		passwordFile = "/@/skk.pass";
		extraGroups = [ "wheel" "audio" "video" "render" "adbusers" ];
	};
}
