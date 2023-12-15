{ pkgs, lib, ... }: {
	boot.consoleLogLevel = 6;

	boot.loader = {
		efi.canTouchEfiVariables = true;
		
		systemd-boot = {
			enable = true;
			consoleMode = "0";
			configurationLimit = 20;
		};
	};

	specialisation.rescue.configuration = {
		system.nixos.tags = [ "rescue" ];
		boot.kernelParams = [ "systemd.unit=rescue.target" "systemd.setenv=SYSTEMD_SULOGIN_FORCE=1" ];
	};

	specialisation.emergency.configuration = {
		system.nixos.tags = [ "emergency" ];
		boot.kernelParams = [ "systemd.unit=emergency.target" "systemd.setenv=SYSTEMD_SULOGIN_FORCE=1" ];
	};
}
