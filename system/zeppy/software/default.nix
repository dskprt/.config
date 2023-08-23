{ pkgs, ... }: {
	imports = [
		./desktop/hyprland.nix
	];

	services.tlp.enable = true;
	# services.openssh.enable = true;

	programs.fish.enable = true;
	programs.dconf.enable = true;

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

		nvtop
		htop

		rsync
		curl
		binutils
		file
		inetutils
		usbutils
		pciutils
		util-linux
	];

	environment.variables = {
		EDITOR = "micro";
	};

	programs.nano.syntaxHighlight = false;
	environment.defaultPackages = [];
}
