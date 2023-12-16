{ inputs, lib, config, pkgs, ... }:
let
	vscode-extensions = inputs.nix-vscode-extensions.extensions.x86_64-linux.vscode-marketplace;
in
{
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
		username = "kiso";
		homeDirectory = "/home/default";
	};

	programs.home-manager.enable = true;
	
	home.packages = with pkgs; [
		any-nix-shell
		
		discord
		audacious
		vlc
		#krita
		obsidian

		lutris
		legendary-gl
		prismlauncher
		#clonehero
		ferium
		ckan

		kompare
		deluge
		krita

		#graalvm-ce
		#temurin-bin-17
		#jetbrains.idea-community
		jetbrains.clion

		poetry

		fluidsynth
		soundfont-generaluser
		soundfont-fluid

		(vscode-with-extensions.override {
			vscode = vscode-fhs;
			vscodeExtensions = (with vscode-extensions; [
				webfreak.debug
				tamasfe.even-better-toml
				#rust-lang.rust-analyzer
				#vadimcn.vscode-lldb
				mesonbuild.mesonbuild
				ms-python.python
				ms-vscode.cpptools
				ms-vscode.cpptools-themes
				editorconfig.editorconfig
				rioj7.vscode-file-templates
				llvm-vs-code-extensions.vscode-clangd
				#platformio.platformio-ide

				#nadako.vshaxe
				#wiggin77.codedox
				#vshaxe.haxe-debug
				#HaxeFoundation.haxe-hl
				#vshaxe.hxcpp-debugger
				#jeremyfa.ceramic
			]) ++ [
				vscode-extensions."13xforever".language-x86-64-assembly
			];
		})
	];

	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			function fish_prompt
				set_color brblue; printf "<"

				if test -n "$IN_NIX_SHELL"
						set_color --dim brblue; printf "<nix-shell> "; set_color normal
				end

				set_color white; printf "$USER"; set_color magenta; printf "@"; set_color white; printf "$hostname"
				set_color brblack; printf (string replace "$HOME" "~" ":$(pwd)")

				set_color cyan; printf (fish_vcs_prompt)

				set_color brblue; printf "> "; set_color white
			end

			set fish_greeting # Disable greeting
			any-nix-shell fish --info-right | source
		'';
		shellInit = ''
			set -Ux PIPENV_VENV_IN_PROJECT 1
			set -Ux POETRY_VIRTUALENVS_IN_PROJECT 1
			
			set -x HSA_OVERRIDE_GFX_VERSION 11.0.2
			set -x PYTORCH_HIP_ALLOC_CONF garbage_collection_threshold:0.95,max_split_size_mb:128

			set -x WINEDLLOVERRIDES winemenubuilder.exe=d
			set -x WINEDEBUG -all

			set -x EM_CACHE ~/.cache/emscripten
		'';
		shellAliases = {
			".." = "cd ..";
			"..." = "cd ../..";
		};
	};

	programs.mangohud = {
		enable = true;
		settings = {
			#fps_limit = 165;
			#vsync = 0;
			#gl_vsync = 1;

			#preset = 3;

			gpu_stats = true;
			gpu_temp = true;
			#gpu_junction_temp = true;
			gpu_power = true;
			gpu_load_change = true;
			#gpu_fan = true;
			gpu_core_clock = true;

			cpu_stats = true;
			cpu_temp = true;
			cpu_power = true;
			cpu_load_change = true;
			cpu_mhz = true;
			
			#core_load = true;
			#core_load_change = true;

			io_read = true;
			io_write = true;

			vram = true;
			ram = true;

			fps = true;
			frametime = true;

			battery = true;
			#battery_icon = true;

			#font_size = 20;
			round_corners = 8;
			no_display = true;

			gpu_name = true;
			exec_name = true;
		};
	};

	dconf.settings = {
		"org/virt-manager/virt-manager/connections" = {
			autoconnect = ["qemu:///system"];
			uris = ["qemu:///system"];
		};
	};

	home.sessionVariables = {
		#"QT_QPA_PLATFORM" = "wayland";
		#"NIXOS_OZONE_WL" = "1";
		"LUTRIS_SKIP_INIT" = "1";
		"GTK_USE_PORTAL" = "1";
	};

	# Nicely reload system units when changing configs
	systemd.user.startServices = "sd-switch";

	# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
	home.stateVersion = "23.11";
}
