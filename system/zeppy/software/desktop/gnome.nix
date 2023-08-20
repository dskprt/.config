{ pkgs, lib, ... }: {
	services = {
		xserver = {
			enable = true;

			desktopManager.gnome.enable = true;
			displayManager.gdm.enable = true;
		};
		gnome = {
			core-os-services.enable = true;
			core-shell.enable = true;
			core-utilities.enable = true;
			core-developer-tools.enable = false;
			games.enable = false;
		};
	};

	services.gnome.gnome-online-miners.enable = lib.mkForce false;
	services.packagekit.enable = lib.mkForce false;
	services.gnome.gnome-initial-setup.enable = lib.mkForce false;
	#services.gnome.gnome-remote-desktop.enable = lib.mkForce false;
	#services.gnome.rygel.enable = lib.mkForce false;
	services.gnome.sushi.enable = lib.mkForce false;

	programs.gnome-terminal.enable = lib.mkForce true;
	#programs.geary.enable = lib.mkForce false;

	environment.gnome.excludePackages = (with pkgs; [
		gnome-tour
		gnome-user-docs
		orca
		gnome-console
		gnome-photos
	]) ++ (with pkgs.gnome; [
		cheese
		epiphany
		gnome-contacts
		gnome-logs
		gnome-maps
		gnome-music
		nautilus
		totem
	]);

	environment.systemPackages = with pkgs; [
		gnome.gnome-shell-extensions
		gnome.dconf-editor

		cinnamon.nemo-with-extensions
		cinnamon.nemo-fileroller

		gnome.adwaita-icon-theme
	];

	xdg.mime.defaultApplications = {
		"inode/directory" = "nemo.desktop";
		"application/x-gnome-saved-search" = "nemo.desktop";
	};

	# experiment: nemo as desktop icon manager
	services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
		[org.gnome.desktop.background]
		show-desktop-icons=false
		[org.nemo.desktop]
		show-desktop-icons=true
	'';
}

