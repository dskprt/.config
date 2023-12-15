{
	system.autoUpgrade = {
		enable = true;
		dates = "daily";
		operation = "switch";
		flake = "/etc/nixos#contingency";
		allowReboot = true;
		rebootWindow = {
			lower = "03:00";
			upper = "03:33";
		};
		flags = [
			"--recreate-lock-file",
			"-L"
		];
	};
}
