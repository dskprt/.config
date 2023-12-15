{
	description = "nixos configuration";

	inputs = {
		# Nixpkgs
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		# Home manager
		home-manager.url = "github:nix-community/home-manager/master";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

		# Impermanence
		impermanence.url = "github:nix-community/impermanence";

		# Hyprland
		# hyprland.url = "github:hyprwm/Hyprland";

		# Visual Studio Code extensions
		nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
	};

	outputs = {
		nixpkgs,
		home-manager,
		impermanence,
		# hyprland,
		nix-vscode-extensions,
		...
	}@inputs: {
		# NixOS configuration entrypoint
		# Available through 'nixos-rebuild --flake .#your-hostname'
		nixosConfigurations = {
			"workbench" = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; }; # Pass flake inputs to our config
				# > Our main nixos configuration file <
				modules = [ ./system/workbench ];
			};
			"contingency" = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; };
				modules = [ ./system/contingency ];
			};
		};

		# Standalone home-manager configuration entrypoint
		# Available through 'home-manager --flake .#your-username@your-hostname'
		homeConfigurations = {
			"kiso" = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
				extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
				# > Our main home-manager configuration file <
				modules = [ ./home/kiso ];
			};
			"yayoi" = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.x86_64-linux;
				extraSpecialArgs = { inherit inputs; };
				modules = [ ./home/yayoi ];
			};
			"commander" = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.x86_64-linux;
				extraSpecialArgs = { inherit inputs; };
				modules = [ ./home/commander ];
			};
		};
	};
}
