{
	fileSystems."/".options = [ "noatime" "nodiratime" ];
	fileSystems."/tmp".options = [ "size=8G" "noatime" "nodiratime" ];

	fileSystems."/@".options = [ "compress=zstd:2" "space_cache=v2" "discard=async" "commit=60" "noatime" "nodiratime" "ssd" ];
	fileSystems."/home".options = [ "compress=zstd:2" "space_cache=v2" "discard=async" "commit=60" "noatime" "nodiratime" "ssd" ];
	fileSystems."/nix".options = [ "compress=zstd:2" "space_cache=v2" "discard=async" "commit=60" "noatime" "nodiratime" "ssd" ];

	fileSystems."/@".neededForBoot = true;

	fileSystems."/@/data" = {
		device = "/dev/vg_data/nvme";
		fsType = "ext4";
		options = [ "defaults" "noatime" "nodiratime" "nofail" "discard" "commit=60" "errors=remount-ro" ];
	};
}
