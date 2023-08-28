{ pkgs, lib, ... }:
let
	vfioExtraEntries = pkgs.stdenv.mkDerivation rec {
		name = "vfio-extra-entries.txt";
		phases = "buildPhase";
		builder = ./vfio-entry-builder.sh;
		nativeBuildInputs = [ pkgs.coreutils pkgs.util-linux pkgs.gnugrep ];
		PATH = lib.makeBinPath nativeBuildInputs;
		vfioPciIds = "1002:7480,1002:ab30";
	};

	vfioExtraEntriesString = builtins.readFile vfioExtraEntries;
in
{
	imports = [
		#./plymouth.nix
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
			theme = pkgs.stdenv.mkDerivation {
				pname = "workbench-grub-theme";
				version = "1.0";
				src = builtins.path {
					path = ./theme;
					name = "workbench-grub-theme";
				};
				installPhase = "mkdir -p $out && cp * $out/ && cp background.png /boot/";
			};
			extraEntries = vfioExtraEntriesString;
		};
	};
}
