{ pkgs, ... }: {
	boot.kernelPackages = pkgs.linuxPackages_latest;
	boot.kernelParams = [ "amd_pstate=guided" "amd_pstate.replace=1" "amdgpu.ppfeaturemask=0xfff7ffff" ];
	boot.kernelModules = [ "msr" ];

	boot.loader = {
		efi.canTouchEfiVariables = true;
		systemd-boot.enable = true;
	};
}
