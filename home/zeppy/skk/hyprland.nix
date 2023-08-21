{ config, pkgs, ... }: {
	home.packages = with pkgs; [
		xdg-desktop-portal
		xdg-desktop-portal-hyprland

		waybar-hyprland
		kitty
	];

	wayland.windowManager.hyprland.enable = true;
	wayland.windowManager.hyprland.extraConfig = ''
		source = /etc/nixos/home/zeppy/skk/hyprland/default.conf
	'';
}
