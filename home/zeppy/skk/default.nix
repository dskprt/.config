{ inputs, lib, config, pkgs, ... }: {
	# You can import other home-manager modules here
	imports = [
		# If you want to use home-manager modules from other flakes (such as nix-colors):
		# inputs.nix-colors.homeManagerModule
		inputs.hyprland.homeManagerModules.default

		../../../external/nwg-shell/impure.nix
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
			# Workaround for https://github.com/nix-community/home-manager/issues/2942
			allowUnfreePredicate = (_: true);
			# github-desktop needs openssl-1.1.1 :(
			permittedInsecurePackages = [
				"openssl-1.1.1u"
			];
		};
	};

	home = {
		username = "skk";
		homeDirectory = "/home/commander";
	};

	programs.home-manager.enable = true;
	
	home.packages = with pkgs; [
		any-nix-shell
		firefox
	];

	programs.fish = {
		enable = true;
		shellInit = ''
			set -x WINEDLLOVERRIDES winemenubuilder.exe=d
		'';
		interactiveShellInit = ''
			set fish_greeting # Disable greeting
			any-nix-shell fish --info-right | source
		'';
		shellAliases = {
			".." = "cd ..";
			"..." = "cd ../..";
		};
	};

	# Nicely reload system units when changing configs
	systemd.user.startServices = "sd-switch";

	# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
	home.stateVersion = "23.11";
}
