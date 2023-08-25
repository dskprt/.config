{ pkgs, ... }: {
	imports = [
		./plymouth.nix
	];

	boot.kernelPackages = pkgs.linuxPackages_latest;
	boot.kernelParams = [ "amd_pstate=active" "amd_pstate.replace=1" "amdgpu.sg_display=0" "amdgpu.ppfeaturemask=0xfff7ffff" ];
	# boot.kernelModules = [ "msr" ];
	boot.consoleLogLevel = 6;

	boot.loader = {
		efi.canTouchEfiVariables = true;
		
		grub = {
			enable = true;
			efiSupport = true;
			device = "nodev";
			configurationLimit = 20;
			#theme = pkgs.stdenv.mkDerivation {
			#	pname = "workbench-grub-theme";
			#	version = "1.0";
			#	src = builtins.path {
			#		path = ./theme;
			#		name = "workbench-grub-theme";
			#	};
			#	installPhase = "cp * $out";
			#};
		};
	};
}
