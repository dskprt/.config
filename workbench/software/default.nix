{ pkgs, ... }: {
	imports = [
		./desktop/gnome.nix
	];

	#services.tlp.enable = true;
	services.tailscale.enable = true;
	# services.openssh.enable = true;
	services.asusd.enable = true;

	programs.steam.enable = true;
	programs.fish.enable = true;
	programs.dconf.enable = true;
	programs.adb.enable = true;

	programs.nix-index = {
		enable = true;

		enableFishIntegration = true;
		enableBashIntegration = false;
		enableZshIntegration = false;
	};

	environment.systemPackages = with pkgs; [
		home-manager

		git
		micro
		tmux

		nvtop-amd
		htop

		rsync
		curl
		binutils
		file
		inetutils
		usbutils
		pciutils
		util-linux

		nvme-cli
		amdctl
		asusctl

		qemu
		virt-manager

		vivaldi
		vivaldi-ffmpeg-codecs
	];

	nixpkgs.overlays = [
		(final: prev: {
			steam = prev.steam.override ({ extraPkgs ? pkgs': [], ... }: {
				extraPkgs = pkgs': (extraPkgs pkgs') ++ (with pkgs'; [
					openssl
				]);
			});
		})
	];

	virtualisation = {
		#waydroid.enable = true;
		#lxd.enable = true;

		libvirtd = {
			enable = true;
		};
	};

	environment.variables = {
		EDITOR = "micro";
	};

	programs.nano.syntaxHighlight = false;
	environment.defaultPackages = [];
}
