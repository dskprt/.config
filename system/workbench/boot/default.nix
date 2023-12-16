{ pkgs, lib, ... }:
let
	#vfioExtraEntries = pkgs.stdenv.mkDerivation rec {
	#	name = "vfio-extra-entries.txt";
	#	phases = "buildPhase";
	#	builder = ./vfio-entry-builder.sh;
	#	nativeBuildInputs = [ pkgs.coreutils pkgs.util-linux pkgs.gnugrep ];
	#	PATH = lib.makeBinPath nativeBuildInputs;
	#	vfioPciIds = "1002:7480,1002:ab30";
	#};

	#vfioExtraEntriesString = builtins.readFile vfioExtraEntries;
in
{
	imports = [
		#./plymouth.nix
	];

	boot.kernelPackages = pkgs.linuxPackages_latest;
	boot.kernelParams = [ "amd_pstate=active" "amd_pstate.replace=1" "amdgpu.sg_display=0" "amdgpu.ppfeaturemask=0xfff7ffff" ];
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
				installPhase = "mkdir -p $out && cp * $out/";
			};
			#extraEntries = vfioExtraEntriesString;
		};
	};

	specialisation.igpu.configuration = {
		system.nixos.tags = [ "igpu" ];
		boot.kernelParams = [ "asus_wmi.gpu_mux_mode=1" "asus_wmi.dgpu_disable=1" ];
	};

	specialisation.dgpu.configuration = {
		system.nixos.tags = [ "dgpu" ];
		boot.kernelParams = [ "asus_wmi.gpu_mux_mode=0" "asus_wmi.dgpu_disable=0" ];
	};
	
	specialisation.vm.configuration = {
		system.nixos.tags = [ "vfio" ];
		boot.kernelParams = [ "vfio-pci.ids=1002:7480,1002:ab30" ];
		boot.kernelModules = [ "vfio_pci" "vfio" "vfio_iommu_type1" ];
		
		#boot.extraModulePackages = [ pkgs.linuxKernel.packages.linux_6_4.kvmfr ];
		#boot.extraModprobeConfig = ''
		#	options kvmfr static_size_mb=32
		#'';

		#environment.systemPackages = with pkgs; [
		#	looking-glass-client
		#];

		#services.udev.extraRules = ''
		#	SUBSYSTEM=="kvmfr", OWNER="kiso", GROUP="kvm", MODE="0600"
		#'';
	};

	specialisation.rescue.configuration = {
		system.nixos.tags = [ "rescue" ];
		boot.kernelParams = [ "systemd.unit=rescue.target" "systemd.setenv=SYSTEMD_SULOGIN_FORCE=1" "modprobe.blacklist=amdgpu" ];
	};

	specialisation.emergency.configuration = {
		system.nixos.tags = [ "emergency" ];
		boot.kernelParams = [ "systemd.unit=emergency.target" "systemd.setenv=SYSTEMD_SULOGIN_FORCE=1" ];
	};
}