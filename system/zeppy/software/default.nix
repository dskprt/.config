{ pkgs, ... }: {
	imports = [
		./desktop/hyprland.nix
	];

#	services.tlp.enable = true;
#	services.tailscale.enable = true;
	# services.openssh.enable = true;

#	programs.steam.enable = true; # steam needs to by installed system-wide :(
	programs.fish.enable = true;
#	programs.dconf.enable = true;
#	programs.adb.enable = true;

	programs.nix-index = {
		enable = true;

		enableFishIntegration = true;
		enableBashIntegration = false;
		enableZshIntegration = false;
	};

	environment.systemPackages = with pkgs; [
		home-manager

		gitMinimal
		micro
		tmux

#		nvtop
		htop

		rsync
		curl
		binutils
		file
		inetutils
		usbutils
		pciutils
		util-linux
#		nvme-cli
#		amdctl

#		qemu
#		virt-manager
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
#			enable = true;
		};
	};

	environment.etc = {
		"libvirt/qemu.conf" = {
			text = ''
				user = "skk"
			'';

			mode = "0644";
		};
	};

	environment.variables = {
		EDITOR = "micro";
	};

	programs.nano.syntaxHighlight = false;
	environment.defaultPackages = [];
}
