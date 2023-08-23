{ pkgs, ... }: {
	users.users.kiso = {
		isNormalUser = true;
		home = "/home/generic";
		shell = pkgs.fish;
		passwordFile = "/@/kiso.pass";
		extraGroups = [ "wheel" "audio" "video" "render" "adbusers" ];
	};
}
