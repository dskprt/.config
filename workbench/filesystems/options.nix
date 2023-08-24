{
	fileSystems."/".options = [ "noatime" ];
	fileSystems."/tmp".options = [ "size=8G" "noatime" ];

	fileSystems."/@".options = [ "compress=zstd:1" "space_cache=v2" "discard=async" "commit=60" "noatime" "ssd" ];
	fileSystems."/home".options = [ "compress=zstd:1" "space_cache=v2" "discard=async" "commit=60" "noatime" "ssd" ];
	fileSystems."/nix".options = [ "compress=zstd:1" "space_cache=v2" "discard=async" "commit=60" "noatime" "ssd" ];

	fileSystems."/@".neededForBoot = true;
}
