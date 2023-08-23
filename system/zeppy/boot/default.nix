{ pkgs, ... }: {
	boot.kernelPackages = pkgs.linuxPackages_latest;

	boot.loader = {
		efi.canTouchEfiVariables = true;
		systemd-boot.enable = true;
	};
}
