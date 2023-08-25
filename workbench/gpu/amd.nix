{ pkgs, ... }: {
	#boot.initrd.kernelModules = [ "amdgpu" ];
	services.xserver.videoDrivers = [ "amdgpu" ];

	hardware.opengl.driSupport = true;
	hardware.opengl.driSupport32Bit = true;

	hardware.opengl.extraPackages = with pkgs; [
		vaapiVdpau
		libvdpau-va-gl

		hip
		rocm-opencl-icd
		rocm-opencl-runtime
	];

	systemd.tmpfiles.rules = [
		"L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}"
	];
}
