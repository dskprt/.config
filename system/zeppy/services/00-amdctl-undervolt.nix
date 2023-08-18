{
	# pstate #0 ryzen 7 5700u undervolt [1218mv -> 1168mv]
	systemd.services.s00-amdctl-undervolt = {
		script = ''
			/run/current-system/sw/bin/amdctl -m -p0 -v61
		'';
		wantedBy = [ "multi-user.target" ];
	};
}
