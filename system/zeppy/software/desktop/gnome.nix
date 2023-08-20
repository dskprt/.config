{ pkgs, ... }: {
	services = {
		xserver = {
			enable = true;

			desktopManager.gnome.enable = true;
			displayManager.gdm.enable = true;
		};
		gnoome = {
			core-os-services.enable = true;
			core-shell.enable = true;
			core-utilities.enable = true;
			core-developer-tools.enable = false;
			games.enable = false;
		};
	};

	services.gnome.gnome-online-miners.enable = false;
	services.packagekit.enable = false;
	services.gnome.gnome-initial-setup.enable = false;
	#services.gnome.gnome-remote-desktop.enable = false;
	#services.gnome.rygel.enable = false;
	services.gnome.sushi.enable = false;

	programs.gnome-terminal.enable = false;
	#programs.geary.enable = false;

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
		dconf-editor

		cinnamon.nemo-with-extensions
		cinnamon.nemo-file-roller

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

