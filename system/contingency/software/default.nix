{ pkgs, ... }: {
	services.tailscale.enable = true;

	services.openssh = {
		enable = true;
		settings = {
			X11Forwarding = true;
			PermitRootLogin = "no";
			PasswordAuthentication = false;
			AllowUsers = [ "commander" ];
		};
	};

	programs.fish.enable = true;

	security.sudo.enable = false;
	security.doas.enable = true;

	environment.systemPackages = with pkgs; [
		home-manager

		gitFull
		vim
		tmux
		python312

		htop

		rsync
		curl
		binutils
		file
		inetutils
		usbutils
		pciutils
		util-linux

		podman-compose
	];

	virtualisation = {
		podman = {
			enable = true;
			defaultNetwork.settings.dns_enabled = true;
		};
	};

	environment.variables = {
		EDITOR = "vim";
	};

	programs.nano.syntaxHighlight = false;
	environment.defaultPackages = [];
}
