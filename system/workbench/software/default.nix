{ pkgs, ... }: {
	imports = [
		./desktop/plasma5.nix
	];

	#services.tlp.enable = true;
	services.tailscale.enable = true;
	services.asusd.enable = true;

	services.supergfxd = {
		enable = false;
		#settings = {
		#  mode = "Hybrid";
		#  vfio_enable = true;
		#  vfio_save = false;
		#  always_reboot = true;
		#  no_logind = false;
		#  logout_timeout_s = 120;
		#  hotplug_type = "Asus";
		#};
	};

	services.openssh = {
		enable = true;
		settings.X11Forwarding = true;
	};

	#powerManagement.powertop.enable = true;

	programs.steam.enable = true;
	programs.fish.enable = true;
	programs.dconf.enable = true;
	programs.adb.enable = true;
	programs.nix-ld.enable = true;

	programs.nix-index = {
		enable = true;

		enableFishIntegration = true;
		enableBashIntegration = false;
		enableZshIntegration = false;
	};

	environment.systemPackages = with pkgs; [
		home-manager
		cachix

		gitFull
		micro
		tmux
		python312

		nvtop-amd
		htop
		powertop

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
		#supergfxctl

		qemu
		virt-manager

		wineWowPackages.staging
		winetricks
		protontricks

		vivaldi
		vivaldi-ffmpeg-codecs
	];

	nixpkgs.overlays = [
		(final: prev: {
			steam = prev.steam.override ({ extraPkgs ? pkgs': [], ... }: {
				extraPkgs = pkgs': (extraPkgs pkgs') ++ (with pkgs'; [
					openssl
				]) ++ ([(pkgs.runCommand "share-fonts" { preferLocalBuild = true; } ''
					mkdir -p "$out/share/fonts"
					font_regexp='.*\.\(ttf\|ttc\|otf\|pcf\|pfa\|pfb\|bdf\)\(\.gz\)?'
					find ${toString (import ./fonts.nix { inherit pkgs; })} -regex "$font_regexp" \
						-exec ln -sf -t "$out/share/fonts" '{}' \;
				'')]);
			});
		})
	];

	virtualisation = {
		#waydroid.enable = true;
		#lxd.enable = true;

		libvirtd = {
			enable = true;

			qemu.verbatimConfig = ''
cgroup_device_acl = [
	"/dev/kvmfr0", "/dev/kvm",
	"/dev/null", "/dev/zero", "/dev/random", "/dev/urandom",
	"/dev/ptmx", "/dev/pts/ptmx", "/dev/pts/0"
]
#user="kiso"
#group="kvm"
			'';
		};
	};

	environment.variables = {
		EDITOR = "micro";
	};

	programs.nano.syntaxHighlight = false;
	environment.defaultPackages = [];
}
