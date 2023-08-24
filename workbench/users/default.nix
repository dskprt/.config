{ pkgs, ... }: {
	users.mutableUsers = false;

	users.users.kiso = {
                uid = 1000;
		group = "users";
		isNormalUser = true;
                home = "/home/default";
                shell = pkgs.fish;
                passwordFile = "/@/kiso.pass";
                extraGroups = [ "wheel" "audio" "video" "render" "adbusers" ];
        };

	users.users.yayoi = {
		uid = 10000;
		group = "users";
                isNormalUser = true;
                home = "/home/guest";
                shell = pkgs.fish;
                extraGroups = [ ];
        };
}
