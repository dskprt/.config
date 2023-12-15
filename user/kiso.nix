{ pkgs, ... }: {
	users.users.kiso = {
		uid = 1000;
		group = "users";
		isNormalUser = true;
		home = "/home/default";
		shell = pkgs.fish;
		hashedPasswordFile = "/@/kiso.pass";
		extraGroups = [ "wheel" "audio" "video" "render" "adbusers" "kvm" ];
	};
}
