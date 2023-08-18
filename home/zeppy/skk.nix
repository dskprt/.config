{ inputs, lib, config, pkgs, ... }: {
	# You can import other home-manager modules here
	imports = [
		# If you want to use home-manager modules from other flakes (such as nix-colors):
		# inputs.nix-colors.homeManagerModule
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
	programs.mangohud = {
		enable = true;
		#enableSessionWide = true;
	};

	home.packages = with pkgs; [
		any-nix-shell

		discord
		audacious
		vlc
		krita
		obsidian

		lutris
		legendary-gl
		parsec-bin
		#grapejuice
		prismlauncher
		#lunar-client

		#temurin-bin-17
		#temurin-jre-bin-8

		vscode-fhs
		#dotnet-sdk_7
		#jetbrains-toolbox
		github-desktop

		#skypeforlinux
		#xournalpp
		#gnome.adwaita-icon-theme

		vivaldi
		vivaldi-ffmpeg-codecs

		#blender
	];

	programs.fish = {
		enable = true;
		shellInit = ''
			set -Ux PIPENV_VENV_IN_PROJECT 1
			set -x HSA_OVERRIDE_GFX_VERSION 10.3.0
			set -x PYTORCH_CUDA_ALLOC_CONF max_split_size_mb=128
			set -x PYTORCH_HIP_ALLOC_CONF garbage_collection_threshold:0.95,max_split_size_mb:128

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
