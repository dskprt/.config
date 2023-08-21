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
		hyprland.url = "github:hyprwm/Hyprland";
	};

	outputs = {
		nixpkgs,
		home-manager,
		impermanence,
		hyprland,
		...
	}@inputs: {
		# NixOS configuration entrypoint
		# Available through 'nixos-rebuild --flake .#your-hostname'
		nixosConfigurations = {
			"zeppy" = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; }; # Pass flake inputs to our config
				# > Our main nixos configuration file <
				modules = [ ./system/zeppy ];
			};
		};

		# Standalone home-manager configuration entrypoint
		# Available through 'home-manager --flake .#your-username@your-hostname'
		homeConfigurations = {
			"skk@zeppy" = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
				extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
				# > Our main home-manager configuration file <
				modules = [
					./home/zeppy/skk/default.nix
				];
			};
		};
	};
}
