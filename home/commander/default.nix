{ inputs, lib, config, pkgs, ... }: {
	# You can import other home-manager modules here
	imports = [
		# If you want to use home-manager modules from other flakes (such as nix-colors):
		# inputs.nix-colors.homeManagerModule
		# ./gnome.nix
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
		username = "commander";
		homeDirectory = "/home/cmdr";
	};

	programs.home-manager.enable = true;
	
	home.packages = with pkgs; [
		any-nix-shell

		poetry
	];

	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			function fish_prompt
				set_color black; printf "<"

				if test -n "$IN_NIX_SHELL"
						set_color --dim black; printf "<nix-shell> "; set_color normal
				end

				set_color white; printf "$USER"; set_color magenta; printf "@"; set_color white; printf "$hostname"
				set_color brblack; printf (string replace "$HOME" "~" ":$(pwd)")

				set_color cyan; printf (fish_vcs_prompt)

				set_color black; printf "> "; set_color white
			end

			set fish_greeting # Disable greeting
			any-nix-shell fish --info-right | source
		'';
		shellInit = ''
			set -Ux PIPENV_VENV_IN_PROJECT 1
			set -Ux POETRY_VIRTUALENVS_IN_PROJECT 1

			set -x WINEDLLOVERRIDES winemenubuilder.exe=d
			set -x WINEDEBUG -all
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
