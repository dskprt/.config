{ pkgs, config, ... }:
{
	fileSystems."/".options = [ "noatime" "nodiratime" ];
	fileSystems."/tmp".options = [ "noatime" "nodiratime" ];

	fileSystems."/home".options = [ "compress=zstd:2" "space_cache=v2" "discard=async" "commit=60" "noatime" "nodiratime" "ssd" ];
	fileSystems."/nix".options = [ "compress=zstd:2" "space_cache=v2" "discard=async" "commit=60" "noatime" "nodiratime" "ssd" ];

	fileSystems."/var" = {
		device = "/dev/disk/by-label/data";
		fsType = "xfs";
		options = [ "discard" "pquota" "noatime" "nodiratime" ];
		neededForBoot = true;
	};

	system.fsPackages = [ pkgs.bindfs ];

	fileSystems."/usr/share/fonts" = {
		device = (pkgs.buildEnv {
				name = "system-fonts";
				paths = config.fonts.packages;
				pathsToLink = [ "/share/fonts" ];
			}) + "/share/fonts";
		fsType = "fuse.bindfs";
		options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
	};
}
