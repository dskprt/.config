{ inputs, lib, config, pkgs, ... }: {
	# You can import other NixOS modules here
	imports = [
		(inputs.impermanence + "/nixos.nix")

		# subfiles
		./filesystems
		./users
		./boot
		./software
		./gpu/amd.nix
		# ./gpu/nvidia.nix

		# custom systemd services
		# ./services/00-amdctl-undervolt.nix

		# hardware config
		./hardware.nix
	];

	nixpkgs = {
		# You can add overlays here
		overlays = [
			# If you want to use overlays exported from other flakes:
			# neovim-nightly-overlay.overlays.default

			# Or define it inline, for example:
			# (final: prev: {
			#   hi = final.hello.overrideAttrs (oldAttrs: {
			#     patches = [ ./change-hello-to-hi.patch ];
			#   });
			# })
		];
		# Configure your nixpkgs instance
		config = {
			# Disable if you don't want unfree packages
			allowUnfree = true;
		};
	};

	nix = {
		# This will add each flake input as a registry
		# To make nix3 commands consistent with your flake
		registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

		# This will additionally add your inputs to the system's legacy channels
		# Making legacy nix commands consistent as well, awesome!
		nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

		gc = {
			automatic = true;
			dates = "weekly";
			options = "--delete-older-than 21d";
		};

		settings = {
			# Enable flakes and new 'nix' command
			experimental-features = "nix-command flakes";
			# Deduplicate and optimize nix store
			auto-optimise-store = true;
		};
	};
 
	powerManagement = {
		enable = true;
		cpuFreqGovernor = "schedutil";
	};

	zramSwap = {
		enable = true;
		memoryPercent = 100;
	};

	## enable periodic fstrim
	services.fstrim.enable = true;

	## networking
	networking.hostName = "workbench";
	networking.networkmanager.enable = true;

	## time
	time.timeZone = "Europe/Warsaw";

	## console
	i18n.defaultLocale = "en_GB.UTF-8";
	console = {
		#font = "Lat2-Terminus16";
		keymap = "pl";
		earlySetup = true;
	#	colors = [
	#		"282828"
	#		"cc231d"
	#		"989621"
	#		"d79a21"
	#		"458588"
	#		"b16286"
	#		"689d6a"
	#		"a89984"
	#		"928374"
	#		"fb4934"
	#		"b8bb26"
	#		"fabd2f"
	#		"83a598"
	#		"d3869b"
	#		"8ec07c"
	#		"ebdbb2"
	#	];
	};

	## sound
	# sound.enable = false;
	hardware.pulseaudio.enable = false;

	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};

	## firewall
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	networking.firewall.enable = true;

	## https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
	system.stateVersion = "23.11";
}
